document.addEventListener("DOMContentLoaded", function(evt) {
	document.getElementById('chat-send').onsubmit = function(evt) {
		evt.preventDefault();
		evt.stopPropagation();
		msg = document.getElementById("new-msg");
		send = JSON.stringify({act:{chatMessage: msg.value}});
		console.log("sending",send)
		cardgameSocket.send(send);
		document.getElementById("new-msg").value = ""
		return false;
	}
})
