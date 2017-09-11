var gameLobbyChannel;
function gameLobbyGo() {
  gameLobbyChannel = App.cable.subscriptions.create({channel: "GameLobbyChannel", game_lobby_id: '1' }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      console.log("SUCCESSFULLY SUBSCRIBED! GAME ID: " + data.id);
    }
  });
}
