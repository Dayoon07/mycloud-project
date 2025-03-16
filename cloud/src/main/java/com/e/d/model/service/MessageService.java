package com.e.d.model.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.MessageEntity;
import com.e.d.model.entity.UserEntity;
import com.e.d.model.mapper.MessageMapper;
import com.e.d.model.repository.MessageRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MessageService {

	private final MessageRepository messageRepository;
	private final MessageMapper mapper;

	public void send(String resc, String title, String message, long resceiveId, MultipartFile file,
			HttpSession session) throws IOException {
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

		// 방법 1: 파일 내용을 바이트 배열로 읽어서 두 곳에 저장
		try {
			byte[] fileData = file.getBytes();

			// 웹 서버에 저장
			try (FileOutputStream webOutputStream = new FileOutputStream(webFile)) {
				webOutputStream.write(fileData);
			}
		} catch (IOException e) {
			throw new IOException("파일 저장 중 오류 발생: " + e.getMessage());
		}

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
	
	public void send(String resc, String title, String message, long resceiveId, HttpSession session) throws IOException {
		UserEntity user = (UserEntity) session.getAttribute("user");
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

}
