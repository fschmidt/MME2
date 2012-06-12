function onOpened() {
    alert("Channel opened!");
}

function onMessage(msg) {
//	if(onMessageReceived) {
//		onMessageReceived(msg);
//	} else {
//		alert(msg.data);
//	}
	alert(msg.data);
}

function onError(err) {
    alert(err);
}

function onClose() {
    alert("Channel closed!");
}

function sendMessage(path, params) {
	  if (params) {
	    path += '?' + "params=" + params;
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.open('POST', path, true);
	  xhr.send();
};