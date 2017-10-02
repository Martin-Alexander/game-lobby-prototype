/*
Yeah, so I don't know what the fuck is going on here. For whatever reason
if one reloads the page while in the lobby and then leaves `lobbyPlayerCounter`
is `null`. But the weird part is that the code still runs and the desired 
behaviour is achieved (and it doesn't work when the code is commented out).
So purely for the sake of not having a annoying error in the console I've
placed everything inside of a condition that checks first to see if 
`lobbyPlayerCounter` is `null`. And, agains, surprisingly, this has no 
effect on behavior. Yeah...
*/
function updateNumberOfPlayersInEachLobby(gameId, increment) {
  const lobbyPlayerCounter = document.querySelector("#lobby-" + gameId + " > div > .number-of-players-in-lobby");
  if (lobbyPlayerCounter) { // <-- what the fuck
    lobbyPlayerCounter.innerHTML = parseInt(lobbyPlayerCounter.innerHTML) + increment++; 
    if (parseInt(lobbyPlayerCounter.innerHTML < 1)) {
      lobbyPlayerCounter.parentElement.parentElement.style.display = "none";
    }
  }
}

function updateNumberOfUsersOnline(numberOfUsersOnline) {
  document.querySelector("#total-number-of-users-online").innerHTML = numberOfUsersOnline;
}

function capitalize(word) {
  return word[0].toUpperCase() + word.substr(1);
}

function changePlayerRole(gameId, userId, newRole) {
  if (newRole == "player") {
    var oldRole = "observer";
  } else {
    var oldRole = "player";
  }
  if (location.pathname.match("lobby\/" + gameId)) {
    document.querySelector("#user-" + userId + " > .player-role").innerHTML = newRole;
  }
}

function destroyGame(gameId) {
  const lobbyElementToDelete = document.querySelector("#lobby-" + gameId);
  if (lobbyElementToDelete) { document.querySelector("#page").removeChild(lobbyElementToDelete); }
}

function createGame(gameId, hostName) {
  const newLobbyElement = document.createElement("div");
  newLobbyElement.id = "lobby-" + gameId;
  newLobbyElement.innerHTML = `<div>Game ID: <strong>${gameId}</strong></div><div>Number of Players: <strong class=\"number-of-players-in-lobby\">1</strong></div><div>Host: <strong>${hostName}</strong></div><div><a href=\"/lobby/${gameId}\">Join Game</a></div><br>`
  document.querySelector("#page").append(newLobbyElement);
}

function addRemovePlayer(increment, username, userId, newHost) {
  if (increment > 0) {
    const newLobbyPlayerElement = document.createElement("div")
    newLobbyPlayerElement.id = "user-" + userId;
    newLobbyPlayerElement.innerHTML = `<div class=\"player-username\"><strong>${username}</strong></div><span class=\"player-role\">player</span><br><br>`
    document.querySelector("#playerlist").append(newLobbyPlayerElement);
  } else {
    const playerElementToDelete = document.querySelector("#user-" + userId);
    document.querySelector("#playerlist").removeChild(playerElementToDelete);
  }
  document.querySelector("#number-of-players-in-lobby").innerText = parseInt(document.querySelector("#number-of-players-in-lobby").innerText) + increment;
  if (newHost) {
    document.querySelector("#host-username").innerHTML = newHost.username;
    document.querySelector("#user-" + newHost.id + " > .player-host").innerText = "host, ";
  }
}

var userChannel = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if (data.userUpdate) {
      if (location.pathname.match(/^\/$/)) {
        updateNumberOfUsersOnline(data.userUpdate.numberOfUsersOnline);
      } else if (location.pathname.match(/lobby/)) {
        // TODO: Potentially nothing
      }
    } else if (data.playerUpdate && document.cookie[document.cookie.length - 1] != data.playerUpdate.userId) {
      // Homepage updates
      if (location.pathname.match(/^\/$/)) {
        if (data.playerUpdate.change.incrementPlayerCount) {
          updateNumberOfPlayersInEachLobby(data.playerUpdate.gameId, data.playerUpdate.change.incrementPlayerCount);
        }
        if (data.playerUpdate.change == "gameDestroy") {
          destroyGame(data.playerUpdate.gameId);
        }
        if (data.playerUpdate.change.newGame) {
          createGame(data.playerUpdate.gameId, data.playerUpdate.change.newGame.hostName);
        }
      // In-lobby updates
      } else if (location.pathname.match(/lobby/)) {
        if (data.playerUpdate.change.newRole) {
          changePlayerRole(data.playerUpdate.gameId, data.playerUpdate.userId, data.playerUpdate.change.newRole);
        }
        if (data.playerUpdate.change.incrementPlayerCount && data.playerUpdate.gameId == location.pathname.match(/lobby\/(\d*)/)[1]) {
          addRemovePlayer(data.playerUpdate.change.incrementPlayerCount, data.playerUpdate.change.username, data.playerUpdate.userId, data.playerUpdate.change.newHost);
        }
      }
    }
  }
});