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
	xhr.open("POST", `${location.origin}/mycloud/fileupload`, true);
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