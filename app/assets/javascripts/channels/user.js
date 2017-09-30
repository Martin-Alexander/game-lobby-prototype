var userChannel = App.cable.subscriptions.create("UserChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    console.log("Recieved data: " + data.total_number_of_users_online);
    const userTracker = document.querySelector("#total-number-of-users-online")
    if (userTracker) { userTracker.innerHTML = data.total_number_of_users_online; }
  }
});
