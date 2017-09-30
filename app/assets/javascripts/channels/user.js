function updateNumberOfUsersOnline(numberOfUsersOnline) {
  document.querySelector("#total-number-of-users-online").innerHTML = numberOfUsersOnline;
}

function updateNumberOfPlayersInEachLobby(gameId, increment) {
  const lobbyPlayerCounter = document.querySelector("#lobby-" + gameId + " > div > .number-of-players-in-lobby");

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

  if (lobbyPlayerCounter) { // <-- what the fuck
    lobbyPlayerCounter.innerHTML = parseInt(lobbyPlayerCounter.innerHTML) + increment++; 
    if (parseInt(lobbyPlayerCounter.innerHTML < 1)) {
      lobbyPlayerCounter.parentElement.parentElement.style.display = "none";
    }
  }
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

    // const changeRoleButtonLink = document.querySelector("#change-role-button > div > a");
    // changeRoleButtonLink.href = changeRoleButtonLink.href.replace(newRole, oldRole);
    // changeRoleButtonLink.firstElementChild.innerText = capitalize(oldRole);
  }
}

function destroyGame(gameId) {
  const lobbyElementToDelete = document.querySelector("#lobby-" + gameId);
  if (lobbyElementToDelete) { document.querySelector("#page").removeChild(lobbyElementToDelete); }
}

function createGame(gameId, hostName) {
  console.log(location.pathname);
  const newLobbyElement = document.createElement("div");
  newLobbyElement.id = "lobby-" + gameId;
  newLobbyElement.innerHTML = `<div>Game ID: <strong>${gameId}</strong></div><div>Number of Players: <strong class=\"number-of-players-in-lobby\">1</strong></div><div>Host: <strong>${hostName}</strong></div><div><a href=\"/lobby/${gameId}\">Join Game</a></div><br>`
  document.querySelector("#page").append(newLobbyElement);
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
      } else if (location.pathname.match(/lobby/)) {
        if (data.playerUpdate.change.newRole) {
          changePlayerRole(data.playerUpdate.gameId, data.playerUpdate.userId, data.playerUpdate.change.newRole);
        }
      }
    }
  }
});