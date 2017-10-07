function ajax(arguments) {
  const successCallbackFunction = arguments.success;
  const httpRequest = new XMLHttpRequest();
  if (!httpRequest) { return false;}
  httpRequest.onreadystatechange = checkForResponse;
  httpRequest.open(arguments.method, arguments.url);
  httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  httpRequest.send("message=" + arguments.data);

  function checkForResponse() {
    if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
      successCallbackFunction(httpRequest.responseText);
    }
  }
}
