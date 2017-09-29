var userChannel = App.cable.subscriptions.create("UserChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      console.log("Number of users: " + data.number_of_users_online);
    }
  });
