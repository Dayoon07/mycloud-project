window.addEventListener("load", () => {
	document.getElementById("loading").style.display = "none";
});
function me() {
	document.getElementById("mo").classList.remove("hidden");
	document.getElementById("momo").classList.remove("hidden");
}
function closeMe() {
	document.getElementById("mo").classList.add("hidden");
	document.getElementById("momo").classList.add("hidden");
}
function openSide() {
	const nav = document.querySelector("nav");
	nav.classList.remove("hidden");
	document.querySelectorAll("span[onclick='openSide()']").forEach(e => {
		e.setAttribute("onclick", "closeSide()");
	});
}
function closeSide() {
	const nav = document.querySelector("nav");
	nav.classList.add("hidden");
	document.querySelectorAll("span[onclick='closeSide()']").forEach(e => {
		e.setAttribute("onclick", "openSide()");
	});
}
function accesskeyLoc() {
	const value = document.getElementById("accesskey").value;
	document.getElementById("accesskeyLocation").setAttribute("href", value);
}