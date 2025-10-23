package com.e.d.model.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	private final JavaMailSender mailSender; // 추가
	
	// 파일 첨부 있는 경우
	public void send(String resc, String title, String message, long resceiveId, 
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
		
		// 이메일 전송
		sendEmail(user.getUsername(), resc, title, message, file);
		
		// DB 저장
		MessageEntity msg = MessageEntity.builder()
				.sender(user.getUsername())
				.receiver(resc)
				.receiveId(resceiveId)
				.title(title)
				.content(message)
				.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss")))
				.contentFile("/resources/mail/" + fileName)
				.build();
		
		messageRepository.save(msg);
	}
	
	// 파일 첨부 없는 경우
	public void send(String resc, String title, String message, long resceiveId, 
			HttpSession session) throws IOException, MessagingException {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		
		// 이메일 전송
		sendEmail(user.getUsername(), resc, title, message, null);
		
		// DB 저장
		MessageEntity msg = MessageEntity.builder()
				.sender(user.getUsername())
				.receiver(resc)
				.receiveId(resceiveId)
				.title(title)
				.content(message)
				.datetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd a HH:mm:ss")))
				.build();
		
		messageRepository.save(msg);
	}
	
	// 이메일 전송 메서드
	private void sendEmail(String from, String to, String subject, String content, 
			MultipartFile file) throws MessagingException, IOException {
		
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		
		helper.setFrom(from);
		helper.setTo(to);
		helper.setSubject(subject);
		helper.setText(content, true); // true = HTML 형식
		
		// 파일 첨부
		if (file != null && !file.isEmpty()) {
			helper.addAttachment(file.getOriginalFilename(), file);
		}
		
		mailSender.send(mimeMessage);
		log.info("이메일 전송 완료: {} -> {}", from, to);
	}
}