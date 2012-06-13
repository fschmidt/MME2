function onOpened() {
    alert("Channel opened!");
}

function onMessage(msg) {
	onMessageReceived(msg.data);
}

function onError(err) {
	onErrorReceived(err);
}

function onClose() {
    onChannelClosed();
}

function sendMessage(path, params) {
	  if (params) {
	    path += '?' + "params=" + params;
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.open('POST', path, true);
	  xhr.send();
};