function Unit(attributes) {
  this.square = attributes.square;
  this.player = attributes.player;
  this.moves = attributes.moves;
};

Unit.prototype.serialize = function() {
  return {
    playerNumber: this.player.number,
    moves: this.moves
  }
};