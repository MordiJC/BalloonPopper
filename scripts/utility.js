function getRandom(a, b) {
	var t = Math.min(a,b); b = Math.max(a,b); a = t
	return Math.random() * (b-a+1) + a;
}

// Get random int from range: <a, b>
function getRandomInt(a, b) {
	var t = Math.min(a,b); b = Math.max(a,b); a = t
	return Math.floor(Math.random() * (b-a+1)) + a;
}
