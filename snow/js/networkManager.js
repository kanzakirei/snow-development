function request(_endPoint, _json, _onSuccessed = null, _onErrored = null) {
  const headers = new Headers();
  headers.append('Content-Type', 'application/x-www-form-urlencoded');
  const request = new Request(_endPoint, {
    method: 'POST',
    mode: 'no-cors',
    headers: headers,
    body: _json
  });
  fetch(request)
    .then(response => {
      if (_onSuccessed != null) _onSuccessed(response);
    })
    .catch(error => {
      if (_onErrored != null) _onErrored(error);
    });
}