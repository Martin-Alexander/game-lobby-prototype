var userChannel = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $("#number-of-users-online").text(data.number_of_users_online);
  }
});
