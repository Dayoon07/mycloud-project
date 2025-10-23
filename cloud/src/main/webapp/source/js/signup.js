async function submit() {
	// 입력 필드의 값들 가져오기
	const username = document.getElementById("username").value;
	const email = document.getElementById("email").value;
	const password = document.getElementById("password").value;
	
	// FormData 객체 생성
	const formData = new FormData();
	formData.append("username", username);
	formData.append("email", email);
	formData.append("password", password);

	// infoBar 요소 가져오기
	const infoBar = document.getElementById("infoBar");
	const infoTitle = document.getElementById("infoTitle");
	const infoMessage = document.getElementById("infoMessage");

	if (!document.getElementById("username").value == "" &&
		!document.getElementById("email").value == "" &&
		!document.getElementById("password").value == "") {
	
		try {
			// 비동기로 폼 데이터 전송 (POST 방식)
			const res = await fetch(`${location.origin}/mycloud/signup`, {
				method: 'POST',
				body: formData
			});
	
			if (res.ok) {
				infoBar.classList.remove("hidden");
				infoBar.classList.add("bg-teal-100", "border-teal-500");
				infoTitle.textContent = "회원가입 성공!";
				infoMessage.textContent = "정상적으로 회원가입이 완료되었습니다.";
	
				// 일정 시간 후 메시지 사라지게 하기
				setTimeout(() => {
					infoBar.classList.add("hidden");
					location.href = location.origin + "/login";
				}, 5000);
	
			} else {
				infoBar.classList.remove("hidden");
				infoBar.classList.add("bg-red-100", "border-red-500");
				infoTitle.textContent = "회원가입 실패";
				infoMessage.textContent = "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.";
	
				setTimeout(() => {
					infoBar.classList.add("hidden");
				}, 5000);
			}
		} catch (error) {
			// 네트워크 오류 등 처리
			infoBar.classList.remove("hidden");
			infoBar.classList.add("bg-red-100", "border-red-500");
			infoTitle.textContent = "서버 오류";
			infoMessage.textContent = "서버와의 연결에 실패했습니다.";
	
			setTimeout(() => {
				infoBar.classList.add("hidden");
			}, 5000);
	
			console.error(error);
		}
	}
}

let isUsernameAvailable = true;

// username 입력란에 대한 이벤트 리스너
document.getElementById('username').addEventListener('input', function() {
	var username = document.getElementById('username').value;

	// 사용자 이름 중복 여부를 체크
	fetch(`${location.origin}/mycloud/chkUsrName?username=${username}`, { method: 'POST' })
		.then(response => response.json())
		.then(data => {
			isUsernameAvailable = data; // 중복 여부 상태 업데이트

			if (isUsernameAvailable) {
				document.getElementById('username-feedback').innerText = "사용 가능한 이름입니다.";
				document.getElementById('username-feedback').style.color = "green";
			} else {
				document.getElementById('username-feedback').innerText = "이미 사용 중인 이름입니다.";
				document.getElementById('username-feedback').style.color = "red";
			}
			if (document.getElementById('username').value == "") {
				document.getElementById('username-feedback').innerText = "이름을 입력해주세요.";
				document.getElementById('username-feedback').style.color = "red";
			}

		});
});

// 회원가입 폼 제출 시 중복된 이름이 있을 경우 제출을 막는 함수
document.querySelector("button[onclick='submit()']").addEventListener("click", (event) => {
	// 이름 중복 확인이 안 된 상태에서 폼을 제출하면 안 됨
	if (!isUsernameAvailable) {
		event.preventDefault(); // 폼 제출을 막음
		alert("이미 사용 중인 이름입니다. 다른 이름을 사용해주세요.");
	} else if (document.getElementById('username').value == "") {
		event.preventDefault();
		alert("이름을 입력해주세요.");
	} else if (document.getElementById("email").value == "") {
		event.preventDefault();
		alert("이메일을 입력해주세요.");
	} else if (document.getElementById("password").value == "") {
		event.preventDefault();
		alert("비밀번호를 입력해주세요.");
	} else if (document.getElementById('username').value.includes(' ')) {
		event.preventDefault();
		alert("이름에는 공백이 들어갈 수 없습니다.");
	}
});