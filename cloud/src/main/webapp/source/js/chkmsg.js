async function fuckCorsConfig(id) {
	try {
		const fd = new FormData();
		fd.append("msgId", id);
		const res = await fetch(`${location.origin}/mycloud/findMail`, {
			method: "POST",
			body: fd
		});
		if (res.status == 200) {
			const data = await res.json();
			console.log(data);
			particularDisplay(data);
		}
	} catch (error) {
		console.log(error);
	}
}
/*
	content
	datetime
	msgId
	receiveId
	receiver
	sender
	title
*/
function particularDisplay(obj) {
	const div = document.createElement("div");
	const v = "mailModal border-l w-full fixed top-0 md:left-64 bg-white p-5 h-full overflow-y-auto";
	div.classList.add(...v.split(" "));

	const exten = formatDate() + (obj.contentFile ? obj.contentFile.substring(obj.contentFile.lastIndexOf(".")) : '');
	console.log(exten);

	// 파일 확장자 추출
	let mediaElement = '';
	if (obj.contentFile) {
		const fileExtension = obj.contentFile.substring(obj.contentFile.lastIndexOf(".") + 1).toLowerCase();

		if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'gif' || fileExtension === 'bmp') {
			mediaElement = `<img src="${obj.contentFile}" class="lg:w-96 w-full" />`;
		} else if (fileExtension === 'mp4' || fileExtension === 'webm' || fileExtension === 'ogg') {
			mediaElement = `<video src="${obj.contentFile}" controls class="lg:w-96 w-full"></video>`;
		} else {
			mediaElement = `<a href="${obj.contentFile}" download="${exten}" class="text-blue-500 hover:underline">파일 다운로드</a>`;
		}
	} else {
		mediaElement = `<p class="text-red-500">첨부된 파일이 없습니다.</p>`;
	}

	div.innerHTML = `
	    <div>
	        <img src="${location.origin}/mycloud/source/img/q.png" onclick="closeMailModal()" 
	            class="w-12 h-12 cursor-pointer rounded-full p-4 hover:bg-gray-100">
	    </div>
	    <div style="font-size: 14px;">${obj.datetime}</div>
	    <h1 class="text-xl">${obj.title}</h1>
	    <p class="font-semibold my-2">보낸 사람: ${obj.sender}</p>
	    <div>
	        <pre style="word-wrap: break-word; white-space: pre-wrap;">${obj.content}</pre>
	    </div>
	    ${mediaElement}
	`;

	console.log(obj.msgId);

	document.querySelector("body").append(div);
}
function closeMailModal() {
	const modal = document.querySelector(".mailModal");
	if (modal) modal.remove();
}
function formatDate() {
	const now = new Date();

	const year = now.getFullYear();
	const month = String(now.getMonth() + 1).padStart(2, '0');
	const day = String(now.getDate()).padStart(2, '0');

	const hours = String(now.getHours()).padStart(2, '0');
	const minutes = String(now.getMinutes()).padStart(2, '0');
	const seconds = String(now.getSeconds()).padStart(2, '0');

	const ampm = hours >= 12 ? '오후' : '오전';
	const hour12 = hours % 12 || 12;

	return `${year}-${month}-${day} ${ampm} ${hour12}-${minutes}-${seconds}`;
}
