function Player(attributes) {
  this.number = attributes.number;
  this.type = attributes.type;
}

Player.prototype.serialize = function() {
  return {
    number: this.number,
    type: this.type
  }
}