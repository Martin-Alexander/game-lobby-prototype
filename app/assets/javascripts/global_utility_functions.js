function ajax(arguments) {
  const successCallbackFunction = arguments.success;
  const httpRequest = new XMLHttpRequest();
  if (!httpRequest) { return false;}
  httpRequest.onreadystatechange = checkForResponse;
  httpRequest.open(arguments.method, arguments.url);
  if (arguments.method == "POST") {
    httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  }
  httpRequest.send("main=" + JSON.stringify(arguments.data));

  function checkForResponse() {
    if (httpRequest.readyState == XMLHttpRequest.DONE && httpRequest.status == 200) {
      successCallbackFunction(httpRequest.responseText);
    }
  }
}

function convertObjectToPostBody(object) {
  const output = [];
  const objectKeys = Object.keys(object);
  for (let i = 0; i < objectKeys.length; i++) {
    output.push(`${objectKeys[i]}=${object[objectKeys[i]]}`)
  }
  return output.join('&')
}