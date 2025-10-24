package com.e.d.model.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.MessageEntity;
import com.e.d.model.entity.UserEntity;
import com.e.d.model.mapper.MessageMapper;
import com.e.d.model.repository.MessageRepository;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MessageService {
	
	private final MessageRepository messageRepository;
	private final MessageMapper mapper;
	private final JavaMailSender mailSender;
	
	// Gmail 발신자 이메일 (application.properties에 설정된 값)
	private static final String FROM_EMAIL = "cloud.mycloud.service@gmail.com";
	
	// 파일 첨부 있는 경우
	public void send(String resc, String title, String message, Long receiverId, 
			MultipartFile file, HttpSession session) throws IOException, MessagingException {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		String webPath = session.getServletContext().getRealPath("/resources/mail/");
		String uuid = UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 30);
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		String fileName = now + "_" + uuid + extension;
		
		File webDir = new File(webPath);
		if (!webDir.exists()) {
			if (!webDir.mkdirs()) {
				throw new IOException("웹 업로드 폴더를 생성할 수 없습니다: " + webPath);
			}
		}
		
		File webFile = new File(webDir, fileName);
		
		try {
			byte[] fileData = file.getBytes();
			try (FileOutputStream webOutputStream = new FileOutputStream(webFile)) {
				webOutputStream.write(fileData);
			}
		} catch (IOException e) {
			throw new IOException("파일 저장 중 오류 발생: " + e.getMessage());
		}
		
		// DB 저장 (먼저 저장)
		MessageEntity msg = MessageEntity.builder()
				.sender(user.getUsername())
				.receiver(resc)
				.receiverId(receiverId)
				.title(title)
				.content(message)
				.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss")))
				.contentFile("/resources/mail/" + fileName)
				.build();
		
		messageRepository.save(msg);
		log.info("메시지 DB 저장 완료 - ID: {}", msg.getMsgId());
		
		// 이메일 전송 (비동기)
		sendEmailAsync(user.getUsername(), user.getUseremail(), resc, title, message, webFile.getAbsolutePath(), file.getOriginalFilename());
	}
	
	// 파일 첨부 없는 경우
	public void send(String resc, String title, String message, long receiverId, 
			HttpSession session) throws IOException, MessagingException {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		
		// DB 저장 (먼저 저장)
		MessageEntity msg = MessageEntity.builder()
				.sender(user.getUsername())
				.receiver(resc)
				.receiverId(receiverId)
				.title(title)
				.content(message)
				.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss")))
				.build();
		
		messageRepository.save(msg);
		log.info("메시지 DB 저장 완료 - ID: {}", msg.getMsgId());
		
		// 이메일 전송 (비동기)
		sendEmailAsync(user.getUsername(), user.getUseremail(), resc, title, message, null, null);
	}
	
	/**
	 * 비동기 이메일 전송 메서드
	 * @Async 어노테이션으로 별도 스레드에서 실행
	 */
	@Async
	public void sendEmailAsync(String senderName, String senderEmail, String to, 
			String subject, String content, String filePath, String fileName) {
		try {
			log.info("이메일 비동기 전송 시작 - 수신자: {}", to);
			sendEmailSync(senderName, senderEmail, to, subject, content, filePath, fileName);
			log.info("이메일 전송 성공: {} ({}) -> {}", senderName, senderEmail, to);
		} catch (Exception e) {
			log.error("이메일 전송 실패: {} -> {}, 오류: {}", senderEmail, to, e.getMessage(), e);
		}
	}
	
	/**
	 * 동기 이메일 전송 메서드 (실제 전송 로직)
	 */
	private void sendEmailSync(String senderName, String senderEmail, String to, 
			String subject, String content, String filePath, String fileName) throws MessagingException, IOException {
		
		// 수신자 이메일 주소 유효성 검증
		if (to == null || to.trim().isEmpty()) {
			log.warn("수신자 이메일 주소가 비어있음");
			throw new MessagingException("수신자 이메일 주소가 비어있습니다");
		}
		
		// 이메일 형식 간단 검증
		String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
		if (!to.matches(emailRegex)) {
			log.warn("유효하지 않은 이메일 형식: {}", to);
			throw new MessagingException("유효하지 않은 이메일 형식: " + to);
		}
		
		log.debug("이메일 전송 시도 - 수신자: {} (도메인: {})", to, to.substring(to.indexOf("@")));
		
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			
			// 발신자를 Gmail 계정으로 설정하고, 이름만 사용자 이름으로 표시
			helper.setFrom(FROM_EMAIL, senderName);
			
			// Reply-To를 사용자의 실제 이메일로 설정 (수신자가 답장할 때 사용)
			if (senderEmail != null && senderEmail.matches(emailRegex)) {
				helper.setReplyTo(senderEmail);
			}
			
			helper.setTo(to);
			helper.setSubject(subject);
			
			// 이메일 본문 (HTML 형식)
			String htmlContent = String.format(
				"<div style='font-family: Arial, sans-serif; padding: 20px;'>" +
				"<div style='border-bottom: 2px solid #3b82f6; padding-bottom: 10px; margin-bottom: 20px;'>" +
				"<p style='margin: 5px 0;'>발신자: <strong>%s</strong></p>" +
				"<p style='margin: 5px 0; color: #6b7280;'>이메일: %s</p>" +
				"</div>" +
				"<div style='margin-top: 20px; line-height: 1.6;'>%s</div>" +
				"<div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb; color: #9ca3af; font-size: 12px;'>" +
				"<p>이 메시지는 마이 클라우드를 통해 발송되었습니다.</p>" +
				"<p>이 메일은 발신 전용입니다. 회신하셔도 답변되지 않습니다.</p>" +
				"</div>" +
				"</div>",
				senderName, senderEmail, content.replace("\n", "<br>")
			);
			
			helper.setText(htmlContent, true);
			
			// 파일 첨부
			if (filePath != null && fileName != null) {
				File file = new File(filePath);
				if (file.exists()) {
					helper.addAttachment(fileName, file);
					log.debug("파일 첨부 완료: {}", fileName);
				} else {
					log.warn("첨부 파일이 존재하지 않음: {}", filePath);
				}
			}
			
			mailSender.send(mimeMessage);
			log.debug("메일 전송 완료: {} -> {}", FROM_EMAIL, to);
			
		} catch (MessagingException e) {
			log.error("MessagingException 발생: {}", e.getMessage(), e);
			throw new MessagingException("메일 전송 중 오류 발생: " + e.getMessage(), e);
		} catch (Exception e) {
			log.error("알 수 없는 오류 발생: {}", e.getMessage(), e);
			throw new MessagingException("메일 전송 중 알 수 없는 오류 발생: " + e.getMessage(), e);
		}
	}
}