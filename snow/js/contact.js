appendScript("networkManager.js");

function onClickedContactButton() {
  const nameForm = document.getElementById("nameForm");
  const messageForm = document.getElementById("messageForm");

  if (nameForm && nameForm.value && messageForm && messageForm.value) {
    document.getElementById('formWrapper').style.display = 'none';
    document.getElementById('waitMessage').style.display = 'block';

    var api = "https://script.google.com/macros/s/AKfycbwyoAxPpNTmtEjGvoYi5qdz4cu8SvUfJpWAmhe-wSGQHCWK-kFSmn2UddnrUdbdo4yO/exec";
    var json = JSON.stringify({ name: nameForm.value, message: messageForm.value });
    request(api, json, function (json) {
      document.getElementById('waitMessage').style.display = 'none';
      document.getElementById('thxMessage').style.display = 'block';
    });
  }
}
