var userChannel = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    
    if (data.totalNumberOfUsersOnline) {
      const userTracker = document.querySelector("#total-number-of-users-online")
      if (userTracker) { userTracker.innerHTML = data.totalNumberOfUsersOnline; }
    }
    if (data.updateNumberOfPlayersInLobby) {
      const lobbyPlayerCounter = document.querySelector("#lobby-" + data.updateNumberOfPlayersInLobby.gameId)
      if (lobbyPlayerCounter) { 
        lobbyPlayerCounter.innerHTML = parseInt(lobbyPlayerCounter.innerHTML) + data.updateNumberOfPlayersInLobby.increment++;
      }
    }
  }
});
