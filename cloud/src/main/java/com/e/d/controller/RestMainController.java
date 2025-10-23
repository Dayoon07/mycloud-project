package com.e.d.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.entity.UserEntity;
import com.e.d.model.mapper.FileMapper;
import com.e.d.model.mapper.MessageMapper;
import com.e.d.model.mapper.UserMapper;
import com.e.d.model.repository.FileRepository;
import com.e.d.model.repository.MessageRepository;
import com.e.d.model.repository.UserRepository;
import com.e.d.model.service.FileService;
import com.e.d.model.service.MessageService;
import com.e.d.model.service.UserService;
import com.e.d.model.vo.UserVo;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
public class RestMainController {

	private final FileRepository filesRepository;
	private final MessageRepository messageRepository;
	private final UserRepository userRepository;
	
	private final FileMapper fileMapper;
	private final MessageMapper messageMapper;
	private final UserMapper userMapper;
	
	private final FileService fileService;
	private final MessageService messageService;
	private final UserService userService;
	
	@PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestParam String username, @RequestParam String email, @RequestParam String password) {
		if (userRepository.findByUsername(username).isPresent()) {
	        log.warn("회원가입 실패 - 중복된 사용자 이름: {}", username);
	        return ResponseEntity.badRequest().body("이미 존재하는 사용자 이름입니다.");
	    }
	    
	    log.info("회원가입 요청 - 사용자 이름: {}, 이메일: {}", username, email);
	    if (!username.isEmpty() && !email.isEmpty() && !password.isEmpty()) userService.insertNewMember(username, email, password);
	    log.info("회원가입 성공 - 사용자 이름: {}", username);

	    return ResponseEntity.ok("회원가입 성공");
    }
	
	@PostMapping("/chkUsrName")
    public boolean checkUsername(@RequestParam String username) {
        UserEntity existingMember = userRepository.findByUsername(username).orElse(null);
        return existingMember == null;
    }
	
	@PostMapping("/searchEmails")
	public List<UserVo> findRecipient(@RequestParam String email) {
	    List<UserVo> list = userMapper.findRecipient(email);
	    if (!list.isEmpty()) {
	    	return list;
	    } else {
	    	return Collections.emptyList();
	    }
	}
	
	@PostMapping("/sendMessage")
	public String sendMessage(@RequestParam String resc, @RequestParam String title, 
			@RequestParam String message, @RequestParam long receiveId, 
			@RequestParam(required = false) MultipartFile file, HttpSession s) throws IOException {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user != null) {
	        if (file != null && !file.isEmpty()) {
	            messageService.send(resc, title, message, receiveId, file, s);
	        } else {
	            messageService.send(resc, title, message, receiveId, s);
	        }
	    }
		return "성공적으로 메세지를 전송했습니다.";
	}
	
	@PostMapping("/findMail")
	public ResponseEntity<?> findMail(@RequestParam Long msgId) {
		return ResponseEntity.ok(messageRepository.findById(msgId).orElse(null));
	}
	
	@PostMapping("/deleteFile")
	public ResponseEntity<?> deleteFile(@RequestParam Long fileId, HttpSession session) throws IOException {
		fileService.deleteFile(fileId, session);
		return ResponseEntity.ok(true);
	}
	
	@PostMapping("/changePrivate")
	public ResponseEntity<?> changePrivate(@RequestParam long fileId) {
		fileService.changePrivate(fileId);
		return ResponseEntity.ok(fileId);
	}
	
	@PostMapping("/dropAccount")
	public void dropAccount(@RequestParam Long userId, HttpSession session) throws IOException {
		userService.dropAccount(userId);
		fileService.dropAccountFiles(session);
		session.invalidate();
	}
	
	
	
	 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
