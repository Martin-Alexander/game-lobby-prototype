App.game = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function() {}
});
