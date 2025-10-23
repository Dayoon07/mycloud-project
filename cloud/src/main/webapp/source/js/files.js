async function deleteFile(pkVal) {
	const fo = new FormData();
	fo.append("fileId", pkVal);

	try {
		const res = await fetch(`${location.origin}/mycloud/deleteFile`, {
			method: "POST",
			body: fo
		});

		if (res.ok) {
			const data = await res.json().catch(() => null);
			console.log(data);
			location.reload();
		}
			
	} catch (error) {
		console.log(error);
	}
}

async function changePrivate(k) {
	const f = new FormData();
	f.append("fileId", k);
	
	try {
		const res = await fetch(`${location.origin}/mycloud/changePrivate`, {
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