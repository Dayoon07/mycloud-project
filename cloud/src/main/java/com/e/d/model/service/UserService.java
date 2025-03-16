package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.e.d.model.entity.UserEntity;
import com.e.d.model.mapper.FileMapper;
import com.e.d.model.mapper.MessageMapper;
import com.e.d.model.mapper.UserMapper;
import com.e.d.model.repository.FileRepository;
import com.e.d.model.repository.MessageRepository;
import com.e.d.model.repository.UserRepository;
import com.e.d.model.vo.UserVo;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserService {

	private final FileRepository filesRepository;
	private final MessageRepository messageRepository;
	private final UserRepository repository;
	
	private final FileMapper fileMapper;
	private final MessageMapper messageMapper;
	private final UserMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public void insertNewMember(String username, String email, String password) {
		String n = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH-mm-ss"));
		String key = UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 20);
		String name = username.replaceAll(" ", "-");
		
		UserEntity entity = UserEntity.builder()
				.username(name)
				.useremail(email)
				.password(passwordEncoder.encode(password))
				.createAt(n)
				.fileAccessKey(key)
				.build();
		
		repository.save(entity);
	}
	
	public Optional<UserEntity> signinLogic(String creatorName, String creatorPassword) {
        if (creatorName == null || creatorName.trim().isEmpty() || creatorPassword == null || creatorPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("입력값이 비어있음");
        }
        
        return repository.findByUsername(creatorName)
                .filter(creator -> passwordEncoder.matches(creatorPassword, creator.getPassword()));
    }
	
	public List<UserVo> findRecipient(String email) {
		return mapper.findRecipient(email);
	}
	
	@Transactional
	public void dropAccount(Long userId) {
		repository.deleteByUserId(userId);
	}
	
}
