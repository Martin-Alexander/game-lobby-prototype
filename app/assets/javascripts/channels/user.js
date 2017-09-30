function updateNumberOfUsersOnline(data) {
  document.querySelector("#total-number-of-users-online").innerHTML = data.numberOfUsersOnline;
}

function updateNumberOfPlayersInEachLobby(data) {
  // console.log(data.gameId)
  const lobbyPlayerCounter = document.querySelector("#lobby-" + data.gameId)
  lobbyPlayerCounter.innerHTML = parseInt(lobbyPlayerCounter.innerHTML) + data.increment++;
  if (parseInt(lobbyPlayerCounter.innerHTML < 1)) {
    lobbyPlayerCounter.parentElement.parentElement.style.display = "none";
  }
}

var userChannel = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if (data.userUpdate) {
      if (location.pathname.match(/^\/$/)) {
        updateNumberOfUsersOnline(data.userUpdate);
      } else if (location.pathname.match(/lobby/)) {
        // TODO: Potentially nothing
      }
    } else if (data.playerUpdate) {
      if (location.pathname.match(/^\/$/)) {
        updateNumberOfPlayersInEachLobby(data.playerUpdate);
      } else if (location.pathname.match(/lobby/)) {
        // TODO
      }
    }
  }
});
