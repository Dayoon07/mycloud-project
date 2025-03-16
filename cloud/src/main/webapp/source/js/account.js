function o() {
	document.querySelector("div[onclick='c()']").classList.remove("hidden");
	document.getElementById("m").classList.remove("hidden");	
}
function c() {
	document.querySelector("div[onclick='c()']").classList.add("hidden");
	document.getElementById("m").classList.add("hidden");
}
document.addEventListener("keydown", (e) => {
	if (e.key === "Escape") c();
});
document.getElementById("subBtn").addEventListener("click", async function(e) {
	const a = document.getElementById("userId");
	const fd = new FormData();
	fd.append("userId", a.value);
	try {
		const res = await fetch(`${location.origin}/dropAccount`, {
			method: "POST",
			body: fd
		});
		location.href = location.origin;
	} catch (error) {
		console.log(error);
	}
	
});