function getRquest(method, url, callback) {
  const httpRequest = new XMLHttpRequest();
  if (!httpRequest) { return false;}
  httpRequest.onreadystatechange = checkForResponse;
  httpRequest.open(method, url);
  httpRequest.send();

  function checkForResponse() {
    if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
      callback(httpRequest.responseText);
    }
  }
}
