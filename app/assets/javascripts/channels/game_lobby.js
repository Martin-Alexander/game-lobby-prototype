var gameLobbyChannel;
function gameLobbyGo() {
  gameLobbyChannel = App.cable.subscriptions.create({channel: "GameLobbyChannel"}, {
    connected: function() {},
    disconnected: function() {},
    received: function() {}
  });
}
