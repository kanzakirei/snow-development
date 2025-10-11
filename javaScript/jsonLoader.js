function getJsonFromFile(_path, _onCompleted) {
	let req = new XMLHttpRequest();
	req.open("get", _path, true);
	req.send();
	req.onload = function () {
		let json = JSON.parse(req.responseText);
		_onCompleted(json);
	}
}

function getJsonFromAPI(_path, _onCompleted) {
	let req = new XMLHttpRequest();
	req.open("get", _path, true);
	req.send();
	req.onreadystatechange = function () {
		// サーバーからのレスポンスが完了し、かつ、通信が正常に終了した場合
		if (req.readyState == 4 && req.status == 200) {
			let json = JSON.parse(req.responseText);
			_onCompleted(json);
		}
	}
}
