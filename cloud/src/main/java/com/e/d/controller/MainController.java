package com.e.d.controller;

import java.io.IOException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
	
	private final FileRepository filesRepository;
	private final MessageRepository messageRepository;
	private final UserRepository userRepository;
	
	private final FileMapper fileMapper;
	private final MessageMapper messageMapper;
	private final UserMapper userMapper;
	
	private final FileService fileService;
	private final MessageService messageService;
	private final UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/")
	public String index(Model m, HttpSession s) {
		if (s.getAttribute("user") != null) {
			UserEntity user = (UserEntity) s.getAttribute("user");
			m.addAttribute("myFiles", fileService.getMyFiles(s));
			m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		}
		return "index";
	}
	
	@GetMapping("/login")
	public String login(HttpSession s) {
		return (s.getAttribute("user") == null) ? "user/login" : "index";
	}
	
	@GetMapping("/signUp")
	public String signupPage(HttpSession s) {
		return (s.getAttribute("user") == null) ? "user/signup" : "index";
	}
	
	@PostMapping("/signin")
	public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {
		try {
			Optional<UserEntity> cp = userService.signinLogic(username, password);

			if (cp.isPresent()) {
				UserEntity user = cp.get();
				session.setAttribute("user", user);
				log.info("로그인 성공: 사용자 [{}], ID [{}]", user.getUsername(), user.getUserId());
			} else {
				log.warn("로그인 실패: 사용자 이름 [{}]에 해당하는 계정을 찾을 수 없거나 비밀번호 불일치.", username);
			}
		} catch (IllegalArgumentException e) {
			log.warn("로그인 실패: {}", e.getMessage());
		}

		return "redirect:/";
	}
	
	@PostMapping("/logout")
	public String logout(HttpSession s) {
		if (s.getAttribute("user") != null) s.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/file")
	public String filesPage(HttpSession s, Model m) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user == null) return "user/login";
		
		m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		m.addAttribute("myFiles", filesRepository.findByFileUserIdOrderByCreateAtDesc(user.getUserId()));
		return "cloud/files";
	}
	
	@GetMapping("/upload")
	public String uploadPage(HttpSession s, Model m) {
	    // 1. 로그인 확인
	    UserEntity u = (UserEntity) s.getAttribute("user");
	    if (u == null) return "user/login";
	    
	    // 2. 사용자 용량 확인
	    Double userSize = fileService.selectMyDescSize(u.getUserId());
	    
	    // 3. null 체크 및 용량 제한 확인
	    if (userSize == null) {
	        // 사용자 용량 정보가 없는 경우 (처음 사용자일 수 있음)
	    	m.addAttribute("descSize", userSize);
	        return "cloud/upload";
	    } else if (userSize < 1024) {
	        // 용량이 제한 이하인 경우
	    	m.addAttribute("descSize", userSize);
	        return "cloud/upload";
	    } else {
	        // 용량 초과
	        return "redirect:/";
	    }
	}
	
	@PostMapping("/fileupload")
	public String upload(@RequestParam MultipartFile file, @RequestParam double fileSize, HttpSession s) 
			throws IllegalStateException, IOException {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user == null) return "user/login";
		
		fileService.upload(file, fileSize, s);
		return "redirect:/";
	}
	
	@GetMapping("/lk/{fileLink}")
	public String fileLinkPage(@PathVariable String fileLink, Model m, HttpSession s) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user == null) return "user/login";
		
		m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		m.addAttribute("fileButForUser", filesRepository.findByFileLink(fileLink));
		return "file/file";
	}
	
	@GetMapping("/compose")
	public String composePage(Model m, HttpSession s) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user == null) return "user/login";
		m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		return "message/compose";
	}
	
	@GetMapping("/chkmsg")
	public String chkmsgPage(Model m, HttpSession s) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (user == null) return "user/login";
		
		if (!messageRepository.findByReceiveIdOrderByDatetimeDesc(user.getUserId()).isEmpty()) {
			m.addAttribute("chkMymsg", messageRepository.findByReceiveIdOrderByDatetimeDesc(user.getUserId()));
		}
		m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		return "message/chkmsg";
	}
	
	@GetMapping("/{fileAccessKey}")
	public String showFileDiff(@PathVariable String fileAccessKey, Model m, HttpSession s) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		
		if (user != null) {
			m.addAttribute("descSize", fileService.selectMyDescSize(user.getUserId()));
		}
		m.addAttribute("diffFileList", fileService.showDiffUserFile(fileAccessKey));
		return "file/diff";
	}
	
	@GetMapping("/remove")
	public String removePage(HttpSession s, Model m) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		if (s.getAttribute("user") == null) return "user/login";

		m.addAttribute("pk", user.getUserId());
		return "user/account";
	}
	
	@GetMapping("/access")
	public String accessPage() {
		return "user/access";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
