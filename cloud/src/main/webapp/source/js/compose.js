function handleFilePreview() {
	const file = document.getElementById("file");
	const previewContainer = document.getElementById("preview");

	previewContainer.innerHTML = "";

	if (!file.files || file.files.length === 0) return;

	Array.from(file.files).forEach(fileItem => {
		const reader = new FileReader();
		reader.onload = function(e) {
			const previewElement = document.createElement("div");
			previewElement.classList.add("preview-item", "p-2");

			// 파일 제거 버튼 추가
			const removeBtn = document.createElement("button");
			removeBtn.textContent = "X";
			removeBtn.classList.add("ml-2", "text-red-500", "hover:text-red-700");
			removeBtn.onclick = function() {
				previewContainer.innerHTML = "";
				document.getElementById("file").value = "";
			};
			previewElement.appendChild(removeBtn);

			if (fileItem.type.startsWith("image")) {
				const img = document.createElement("img");
				img.src = e.target.result;
				img.classList.add("md:w-60", "w-full");
				previewElement.appendChild(img);
			} else if (fileItem.type.startsWith("video")) {
				const video = document.createElement("video");
				video.src = e.target.result;
				video.controls = true;
				video.classList.add("md:w-60", "w-full");
				previewElement.appendChild(video);
			} else {
				const text = document.createElement("p");
				text.textContent = fileItem.name;
				text.classList.add("text-sm", "font-semibold");
				previewElement.appendChild(text);
			}
			previewContainer.appendChild(previewElement);
		};
		reader.readAsDataURL(fileItem);
	});
}

async function chk() {
	try {
		const a = document.querySelector("#resc");
		const div = document.getElementById("list");

		const res = await fetch(`${location.origin}/mycloud/searchEmails?email=${a.value}`, {
			method: "POST",
		});

		if (res.ok) {
			const data = await res.json();
			console.log(data);
			let h = "";

			div.classList.remove("hidden");
			data.forEach(m => {
				h += `
                <div class="px-4 py-2 hover:bg-gray-100 cursor-pointer" onclick="wow('${m.useremail}', ${m.userId})">
                    <p>이름 : ${m.username}</p>
                    <p class="text-sm">이메일 : ${m.useremail}</p>
                </div>
                `;
				console.log(m.username);
			});
			div.innerHTML = h;
		}
	} catch (error) {
		console.log(error);
	}
}

function first() {
	document.getElementById("list").classList.add("hidden");
}

function wow(email, id) {
	document.getElementById("resc").value = email;
	document.getElementById("receiveId").value = id;
}

document.getElementById("compose").addEventListener("click", async function(e) {
	const resc = document.getElementById("resc");
	const title = document.getElementById("title");
	const message = document.getElementById("message");
	const receiveId = document.getElementById("receiveId");
	const file = document.querySelector("input[type='file']");
	const previewContainer = document.getElementById("preview");

	if (resc.value == "" || title.value == "" || message.value == "") {
		e.preventDefault();
		alert("입력칸이 비어있습니다.");
		return;
	}

	const f = new FormData();
	f.append("resc", resc.value);
	f.append("title", title.value);
	f.append("message", message.value);
	f.append("receiveId", receiveId.value);

	// 파일이 있는 경우에만 추가
	if (file.files && file.files.length > 0) {
		f.append("file", file.files[0]);
	}

	try {
		const res = await fetch(`${location.origin}/mycloud/sendMessage`, {
			method: "POST",
			body: f
		});

		if (res.ok) {
			const t = await res.text();
			console.log(t);

			// 성공 시 폼 초기화
			resc.value = "";
			title.value = "";
			message.value = "";
			receiveId.value = "";
			file.value = "";
			previewContainer.innerHTML = "";
			alert(t);
		} else {
			alert("메시지 전송에 실패했습니다.");
		}
	} catch (error) {
		console.error("메시지 전송 중 오류 발생:", error);
		alert("메시지 전송 중 오류가 발생했습니다.");
	}
});
document.getElementById("file").addEventListener("change", handleFilePreview);