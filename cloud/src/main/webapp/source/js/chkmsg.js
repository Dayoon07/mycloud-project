/* async function fuckCorsConfig(id) {
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
			// particularDisplay(data);
		}
	} catch (error) {
		console.log(error);
	}
} */
/*
	content
	datetime
	msgId
	receiveId
	receiver
	sender
	title
*/
function particularDisplay(el) {
	const msgId = el.dataset.id;
	const sender = el.dataset.sender;
	const receiver = el.dataset.receiver;
	const title = el.dataset.title;
	const content = el.dataset.content;
	const createAt = el.dataset.datetime;
	const contentFile = el.dataset.contentfile;
	
	const div = document.createElement("div");
	div.classList.add("mailModal", "border-l",  "w-full", "fixed", "top-0", "lg:left-64", "lg:top-16", "bg-white", "pl-4", "pt-3", "pb-40", "h-full", "overflow-y-auto");

	const exten = formatDate() + (contentFile ? contentFile.substring(contentFile.lastIndexOf(".")) : '');
	console.log(exten);

	// 파일 확장자 추출
	let mediaElement = '';
	if (contentFile) {
		const fileExtension = contentFile.substring(contentFile.lastIndexOf(".") + 1).toLowerCase();

		if (fileExtension === 'jpg' || fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'gif' || fileExtension === 'bmp') {
			mediaElement = `<img src="${location.origin}/mycloud${contentFile}" class="lg:w-96 w-full" />`;
		} else if (fileExtension === 'mp4' || fileExtension === 'webm' || fileExtension === 'ogg') {
			mediaElement = `<video src="${location.origin}/mycloud${contentFile}" controls class="lg:w-96 w-full"></video>`;
		} else {
			mediaElement = `<a href="${location.origin}/mycloud${contentFile}" download="${exten}" class="text-blue-500 hover:underline">파일 다운로드</a>`;
		}
	}
	/* else {
		mediaElement = `<p class="text-red-500">첨부된 파일이 없습니다.</p>`;
	} */

	div.innerHTML = `
	    <div>
	        <img src="${location.origin}/mycloud/source/img/q.png" onclick="closeMailModal()" 
	            class="w-12 h-12 cursor-pointer rounded-full p-4 hover:bg-gray-100">
	    </div>
		<div style="margin-bottom: 16px;">
			<h1 style="font-size: 24px;">${title}</h1>
			<p>
				<span style="font-weight: bold;">${sender}</span>
				<span style="color: rgb(94, 94, 94);">&lt;${receiver}&gt;</span>
			</p>
			<p style="font-size: 14px; color: rgb(94, 94, 94);">${createAt}</p>
		</div>
	    <div>
	        <pre style="word-wrap: break-word; white-space: pre-wrap;">${content}</pre>
	    </div>
	    ${mediaElement}
	`;
	console.log(msgId);

	document.querySelector("body").append(div);
}
function closeMailModal() {
	document.querySelectorAll(".mailModal").forEach((e) => {
		e.addEventListener("click", () => {
			console.log(e);
			if (e) e.remove();
			// if (e.target) modal.remove();
		});
	})
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

	return `${year}-${month}-${day}-${ampm}-${hour12}-${minutes}-${seconds}`;
}

document.addEventListener("keydown", (e) => {
	if (e.key === "Escape") {
		document.querySelectorAll(".mailModal").forEach(e => e.remove());	
	}
});
