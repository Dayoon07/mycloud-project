## 프로젝트명 : mycloud-project

<a href="https://dayoon07.github.io/video/mycloud-test.mp4">테스트 영상 주소</a>

## 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [개발 기간](#개발-기간)
3. [IDE](#ide)
4. [db & 서버](#db--서버)
5. [프레임워크](#프레임워크)
6. [언어](#언어)
7. [라이브러리](#라이브러리)
8. [빌드 도구](#빌드-도구)
9. [ERD](#erd)
10. [기능 설명](#기능-설명)

## 프로젝트 소개
<p style="font-size: 24px;">
클라우드를 일부분 구현한 프로젝트입니다. 메일 기능, 엑세스 키 기능을 활용해 다른 사람에게 나의 파일을 공유할 수 있습니다.
</p>

## 개발 기간
<p style="font-size: large;">2025. 03. 12 ~ 2025. 03. 16</p>

![](https://dayoon07.github.io/static-page-test/img/mycloud-screenshot.png)

## IDE

<div style="display: flex; align-items: center;">
    <img src="https://img.shields.io/badge/Spring%20Tool%20Suite%20-6DB33F?style=for-the-badge&logo=eclipse&logoColor=white" alt="Spring Tool Suite" />
    <span style="display: flex; align-items: center; background-color: black; padding: 5px 10px; color: white; font-size: 12px; border-radius: 5px; font-weight: bold">
        <img src="https://dayoon07.github.io/static-page-test/devimg/sqldeveloper.png" width="14" style="margin-right: 8px;" />
        SQL Developer
    </span>
</div>

## DB & 서버
![](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![](https://custom-icon-badges.demolab.com/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=fff)

## 프레임워크

<div style="display: flex; align-items: center;">
    <img src="https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=fff" alt="Spring Boot" />
    <span style="display: flex; align-items: center; background-color: white; padding: 5px 10px; width: 80px; color: black; font-size: 11px; font-weight: bold">
        <img src="https://dayoon07.github.io/static-page-test/devimg/MyBatis.png" width="14" style="margin-right: 8px;" />
        MyBatis
    </span>
    <img src="https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white" alt="tailwind css">
</div>

## 언어

![](https://dayoon07.github.io/img/Java-007396.svg)
![](https://img.shields.io/badge/HTML-%23E34F26?style=for-the-badge&logo=html5&logoColor=white)
![](https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=fff)
![](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=white)

## 라이브러리

<div style="display: flex; align-items: center;">
    <img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=fff" alt="jQuery" />
    <span style="display: flex; align-items: center; background-color: white; padding: 5px 10px; width: 80px; color: black; font-size: 11px; font-weight: bold">
        <img src="https://dayoon07.github.io/static-page-test/devimg/lombok.png" width="14" style="margin-right: 8px;" />
        Lombok
    </span>
    <span style="display: flex; align-items: center; background-color: white; padding: 5px 10px; width: 80px; color: black; font-size: 11px; font-weight: bold">
        <img src="https://dayoon07.github.io/static-page-test/devimg/jstl.png" width="14" style="margin-right: 8px;" />
        JSTL
    </span>
</div>

## 빌드 도구

![](https://img.shields.io/badge/MAVEN-000000?style=for-the-badge&logo=apachemaven&logoColor=blue)

## ERD

![이미지](https://dayoon07.github.io/img/architecture/mycloud-erd.png)

## 기능 설명

<span style="font-size: large; font-weight: bold;">목차</span>

1. [파일 업로드](#파일-업로드)
2. [내 파일](#내-파일)
3. [파일 공개 / 비공개 전환](#파일-공개--비공개-전환)
4. [메세지 확인 & 보내기](#메세지-확인--보내기)
5. [엑세스 키](#엑세스-키)

### 파일 업로드

[프론트 코드](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/WEB-INF/jsp/cloud/upload.jsp) &nbsp; &nbsp; 
[백엔드 코드 (업로드 로직)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/java/com/e/d/model/service/FileService.java#L37)

- 파일은 어떤 파일이여도 업로드 가능
- 이미지, 영상 파일만 페이지 내 보기 가능
- Rest 방식으로 처리할려고 했는데 컨트롤러에 js로 비동기 처리

```js
// 비동기 처리 upload.js 파일
function previewFile() {
	const fileInput = document.getElementById("dropzone-file");
	const file = fileInput.files[0];
	const previewContainer = document.getElementById("preview-div");
	const uploadButton = document.getElementById("upload-btn");
	const progressBar = document.getElementById("upload-progress");
	const uploadText = document.getElementById("uploadText");
	const size = document.getElementById("fileSize");

	if (file) {
		document.getElementById("cloudUI").classList.add("hidden");
		document.getElementById("clse").classList.remove("hidden");
		document.getElementById("clse").setAttribute("onclick", "cle()");

		const reader = new FileReader();
		reader.onload = function(e) {
			let previewElement;
			if (file.type.startsWith("image")) {
				previewElement = document.createElement("img");
				previewElement.src = e.target.result;
				previewElement.classList.add("rounded", "w-96", "mx-auto");
			} else if (file.type.startsWith("video")) {
				previewElement = document.createElement("video");
				previewElement.src = e.target.result;
				previewElement.controls = true;
				previewElement.classList.add("rounded", "w-96", "mx-auto");
			} else {
				previewElement = document.createElement("p");
				previewElement.textContent = file.name;
				previewElement.classList.add("text-sm", "font-semibold");
			}

			previewContainer.innerHTML = "";
			previewContainer.appendChild(previewElement);
		};
		reader.readAsDataURL(file);
		uploadButton.classList.remove("hidden");

		console.log("파일 용량: " + (file.size / 1024 / 1024).toFixed(2) + "MB");

		progressBar.value = 0;
		progressBar.classList.add("hidden");
		uploadText.textContent = "업로드 준비 완료";
	} else {
		document.getElementById("cloudUI").classList.remove("hidden");
		previewContainer.innerHTML = "";
		uploadButton.classList.add("hidden");
		progressBar.classList.add("hidden");
		uploadText.textContent = "";
	}
}

function cle() {
	document.getElementById("clse").classList.add("hidden");
	document.getElementById("dropzone-file").value = "";
	document.getElementById("preview-div").innerHTML = "";
	document.getElementById("upload-progress").classList.add("hidden");
	document.getElementById("uploadText").textContent = "";
	document.getElementById("upload-btn").classList.add("hidden");
	document.getElementById("cloudUI").classList.remove("hidden");
}

document.getElementById("upload-btn").addEventListener("click", function() {
	const fileInput = document.getElementById("dropzone-file");
	const file = fileInput.files[0];
	const progressBar = document.getElementById("upload-progress");
	const uploadText = document.getElementById("uploadText");

	if (!file) {
		alert("파일을 선택하세요.");
		return;
	}

	progressBar.value = 0;
	progressBar.classList.remove("hidden");
	uploadText.textContent = "업로드 중...";

	const xhr = new XMLHttpRequest();
	xhr.open("POST", `${location.origin}/fileupload`, true);
	xhr.setRequestHeader("Accept", "application/json");

	xhr.upload.onprogress = function(event) {
		if (event.lengthComputable) {
			const percent = (event.loaded / event.total) * 100;
			progressBar.value = percent;
		}
	};

	xhr.onload = function() {
		if (xhr.status === 200) {
			uploadText.textContent = "업로드 완료";
			setTimeout(() => {
				alert("업로드 성공");
				location.reload();
			}, 100);
		} else {
			uploadText.textContent = "업로드 실패";
			alert("업로드 실패");
		}
	};

	const formData = new FormData();
	formData.append("file", file);
	formData.append("fileSize", (file.size / 1024 / 1024).toFixed(2));
	xhr.send(formData);
});
```

![](https://dayoon07.github.io/static-page-test/img/mycloud-upload-screenshot.png)

### 내 파일

[프론트 코드](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/WEB-INF/jsp/cloud/files.jsp) &nbsp; &nbsp; 
[백엔드 코드 (파일 불러오기 기능)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/java/com/e/d/controller/MainController.java#L97)

- 파일 다운로드, 삭제 기능
- 파일 시스템 구현할려고 했는데 빨리 만들고 싶어서 안 함
- 서버에 현재 로그인한 사용자자의 pk를 넘겨주는 방식으로 해서 절대 내 파일 페이지에서는 다른 사람의 페이지로 들어가는 것을 방지함

![](https://dayoon07.github.io/static-page-test/img/mycloud-myfile.png)

### 파일 공개 / 비공개 전환

- 이 기능은 파일을 보는 것보다는 이렇게 간단하게 되어 있어서 최대한 readme를 보고 이해하는 게 편함

[프론트 코드](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/WEB-INF/jsp/cloud/files.jsp#L211) &nbsp; &nbsp; 
[백엔드 코드 (Rest 컨트롤러)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/java/com/e/d/controller/RestMainController.java#L104)

```html
<p onclick="changePrivate(${ 파일의 PK값 })">공개 또는 비공개</p>
```

```js
async function changePrivate(k) {
	const f = new FormData();
	f.append("fileId", k);
	
	try {
		const res = await fetch(`${location.origin}/changePrivate`, {
			method: "POST",
			body: f
		});
		const data = await res.json();
		console.log(data);
		location.reload();
	} catch (error) {
		console.log(error);
	}
}
```

```java
// 컨트롤러 레이어 함수
@PostMapping("/changePrivate")
public ResponseEntity<?> changePrivate(@RequestParam long fileId) {
	fileService.changePrivate(fileId);
	return ResponseEntity.ok(fileId);
}

// 서비스 레이어 함수
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
```

![](https://dayoon07.github.io/static-page-test/img/mycloud-change-private.png)
![](https://dayoon07.github.io/static-page-test/img/mycloud-private-screenshot.png)

- 다른 사람이 엑세스 키를 사용해서 볼 때 

![](https://dayoon07.github.io/static-page-test/img/mycloud-asdf.png)

### 메세지 확인 & 보내기

[프론트 코드](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/WEB-INF/jsp/message/compose.jsp) &nbsp; &nbsp; 
[백엔드 코드 (메세지 보내기)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/java/com/e/d/controller/RestMainController.java#L78)

- Rest 방식으로 메세지를 DB에 저장
- 파일 첨부 여부에 따라 send 함수를 오버로딩함

```java
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

		try {
			byte[] fileData = file.getBytes();

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
```

- 여기서부터는 기능이 어떻게 돌아가는 지 이해할려면 js 파일을 봐야됨
- 기능에 대해 간단히 설명하자면 메세지를 보내면 해당 메일을 가진 사용자의 PK를 DB에 저장, websocket을 이용하지 않아서 실시간은 안됨
- [compose.js (메세지 보내기, 1번째 이미지 관련됨)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/source/js/compose.js)
- [chkmsg.js (메세지 확인, 2,3 번째 이미지 관련됨)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/source/js/chkmsg.js)

```java
// 이메일 입력시 관련 이메일 출력
@PostMapping("/searchEmails")
public List<UserVo> findRecipient(@RequestParam String email) {
	List<UserVo> list = userMapper.findRecipient(email);
	if (!list.isEmpty()) {
		return list;
	} else {
		return Collections.emptyList();
	}
}
```

![](https://dayoon07.github.io/static-page-test/img/mycloud-msg-compose.png)
![](https://dayoon07.github.io/static-page-test/img/mycloud-chk-msg.png)
![](https://dayoon07.github.io/static-page-test/img/mycloud-chk-msg-content.png)

### 엑세스 키

[프론트 코드](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/webapp/WEB-INF/jsp/user/access.jsp) &nbsp; &nbsp; 
[백엔드 코드 (컨트롤러)](https://github.com/Dayoon07/mycloud-project/blob/main/cloud/src/main/java/com/e/d/controller/MainController.java#L171)

- 사용자 계정 생성 시 무조건 발생하는 키 생성 로직

```java
package com.e.d.model.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.e.d.model.entity.UserEntity;
import com.e.d.model.repository.UserRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserService {

	private final UserRepository repository;
	
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
				.fileAccessKey(key)	// 여기
				.build();
		
		repository.save(entity);
	}
}
```

- 위에 있는 이 로직으로 계정이 생성된 사용자의 키를 활용해서 다른 사람과 파일을 공유할 수 있도록 설계. 로그인을 하지 않아도 다른 사용자의 엑세스 키를 사용해서 파일을 주고 받을 수 있음
	
![](https://dayoon07.github.io/static-page-test/img/mycloud-key-screenshot.png)
![](https://dayoon07.github.io/static-page-test/img/mycloud-use-access-key.png)


