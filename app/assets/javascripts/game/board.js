function Board(attributes = {}) {
  this.squares = [];
}

Board.prototype.serialize = function() {
  serializedSquares = [];
  for(let i = 0; i < this.squares.length; i++) { 
    serializedSquares.push(this.squares[i].serialize());
  }
  return { squares: serializedSquares };
}
