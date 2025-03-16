package com.e.d.model.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.e.d.model.dto.UserFileDto;
import com.e.d.model.entity.FileEntity;
import com.e.d.model.entity.UserEntity;
import com.e.d.model.mapper.FileMapper;
import com.e.d.model.repository.FileRepository;
import com.e.d.model.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileService {

	private final FileRepository fileRepository;
	private final FileMapper fileMapper;

	private final UserRepository userRepository;

	public void upload(MultipartFile file, double fileSize, HttpSession s) throws IllegalStateException, IOException {
		// 파일 비어있는지 확인
		if (file.isEmpty())
			throw new IllegalStateException("파일이 비어 있습니다.");

		// 사용자 정보 가져오기
		UserEntity user = (UserEntity) s.getAttribute("user");

		// 타임스탬프 생성
		String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss"));
		// UUID 생성 및 정리
		String uuid = UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 20);

		// 파일 확장자 추출
		String extension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		// 파일명 생성
		String fileName = timestamp + "_" + uuid + extension;

		// 업로드 경로 설정 - 두 가지 방식 모두 구현
		String webPath = s.getServletContext().getRealPath("/resources/");

		// 웹 경로에 저장
		File webDir = new File(webPath);
		if (!webDir.exists()) {
			if (!webDir.mkdirs()) {
				throw new IOException("웹 업로드 폴더를 생성할 수 없습니다: " + webPath);
			}
		}

		// 웹 서버에 파일 저장
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

		// 데이터베이스에 파일 정보 저장
		FileEntity entity = FileEntity.builder().fileUserId(user.getUserId()).fileName(file.getOriginalFilename())
				.fileSize(fileSize).fileLocation("/resources/" + fileName).filePrivate("N").createAt(timestamp)
				.fileLink(uuid).build();
		fileRepository.save(entity);

		// 로그 출력
		System.out.println("----------------------------------------------------");
		System.out.println("파일 저장 완료 (웹): " + webFile.getAbsolutePath());
		System.out.println("----------------------------------------------------");
	}

	public void deleteFile(Long fileId, HttpSession s) throws IOException {
		// 파일 정보 조회
		FileEntity fileEntity = fileRepository.findById(fileId)
				.orElseThrow(() -> new IllegalStateException("파일을 찾을 수 없습니다."));

		// 현재 로그인한 사용자 정보 가져오기
		UserEntity user = (UserEntity) s.getAttribute("user");

		// 본인 파일인지 확인
		if (fileEntity.getFileUserId() != user.getUserId()) {
			throw new SecurityException("파일을 삭제할 권한이 없습니다.");
		}

		// 실제 저장된 파일 경로
		String webPath = s.getServletContext().getRealPath(fileEntity.getFileLocation());
		File file = new File(webPath);

		// 파일 삭제
		if (file.exists()) {
			if (!file.delete()) {
				throw new IOException("파일 삭제에 실패했습니다: " + webPath);
			}
		} else {
			System.out.println("파일이 이미 존재하지 않습니다: " + webPath);
		}

		// 데이터베이스에서 파일 정보 삭제
		fileRepository.delete(fileEntity);

		// 로그 출력
		System.out.println("----------------------------------------------------");
		System.out.println("파일 삭제 완료: " + webPath);
		System.out.println("----------------------------------------------------");
	}

	public void dropAccountFiles(HttpSession s) throws IOException {
		// 로그인한 사용자 정보 가져오기
		UserEntity user = (UserEntity) s.getAttribute("user");

		// 해당 사용자의 모든 파일을 조회
		List<FileEntity> filesToDelete = fileRepository.findByFileUserId(user.getUserId());

		if (!filesToDelete.isEmpty()) {
			for (FileEntity fileEntity : filesToDelete) {
				// 실제 저장된 파일 경로
				String webPath = s.getServletContext().getRealPath(fileEntity.getFileLocation());
				File file = new File(webPath);
	
				// 파일 삭제
				if (file.exists()) {
					if (!file.delete()) {
						throw new IOException("파일 삭제에 실패했습니다: " + webPath);
					}
				} else {
					System.out.println("파일이 이미 존재하지 않습니다: " + webPath);
				}
	
				// 데이터베이스에서 파일 정보 삭제
				fileRepository.delete(fileEntity);
	
				// 로그 출력
				System.out.println("----------------------------------------------------");
				System.out.println("파일 삭제 완료: " + webPath);
				System.out.println("----------------------------------------------------");
			}
		}
	}

	public List<FileEntity> getMyFiles(HttpSession s) {
		UserEntity user = (UserEntity) s.getAttribute("user");
		return fileRepository.findByFileUserIdOrderByCreateAtDesc(user.getUserId());
	}

	public Double selectMyDescSize(long id) {
		return fileMapper.selectMyDescSize(id);
	}

	public List<UserFileDto> showDiffUserFile(String accessKey) {
		return fileMapper.showDiffUserFile(accessKey);
	}

	@Transactional
	public void changePrivate(Long fileId) {
		fileRepository.findById(fileId).ifPresent(entity -> {
			if (entity.getFilePrivate().equals("N")) {
				entity.setFilePrivate("Y");
			} else {
				entity.setFilePrivate("N");
			}
		});
	}

}
