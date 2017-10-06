function GameData() {
  this.turn = 0;
  this.board = new Board();
  this.players = [];
};

GameData.findMapSize = function(numberOfPlayers) {
  return Math.floor(Math.sqrt(numberOfPlayers * 128));
}

GameData.prototype.initializeFromGameDataJSON = function(gameDataJSON) {

  // Set turn
  this.turn = gameDataJSON.turn;

  // Set players
  for (let i = 0; i < gameDataJSON.players.length; i++) {
    this.players.push(new Player({
      number: gameDataJSON.players[i].number,
      type: gameDataJSON.players[i].type
    }));
  }

  // Set board
  for (let i = 0; i < gameDataJSON.board.squares.length; i++) {
    let newSquare = new Square({
      x: gameDataJSON.board.squares[i].x,
      y: gameDataJSON.board.squares[i].y,
      testAttribute: gameDataJSON.board.squares[i].testAttribute
    });
    for (let j = 0; j < gameDataJSON.board.squares[i].units.length; j++) {
      newSquare.units.push(new Unit({
        square: newSquare,
        moves: gameDataJSON.board.squares[i].units.moves,
        player: this.getPlayerById(gameDataJSON.board.squares[i].playerNumber)
      }));
    }
    this.board.squares.push(newSquare);
  }
}

GameData.prototype.initializeByGenerationFromSettings = function(settings) {
  
  // Initialize game metadata
  this.turn = 0;

  // Initialize players
  for(let i = 0; i < settings.numberOfPlayers; i++) {
    this.players.push(new Player(settings.players[i]));
  }

  // Initialize board
  const mapSize = GameData.findMapSize(settings.numberOfPlayers);
  for(let y = 0; y < mapSize; y++) {
    for(let x = 0; x < mapSize; x++) {
      let testAttribute;
      if (Math.random() > 0.5) { testAttribute = 0; } else { testAttribute = 0; }
      this.board.squares.push(new Square({ x: x, y: y, testAttribute: testAttribute}));
    }
  }
}

GameData.prototype.toJSON = function() {
  const serializedPlayers = [];
  for(let i = 0; i < this.players.length; i++) {
    serializedPlayers.push(this.players[i].serialize());
  }
  return JSON.stringify({
    turn: this.turn,
    players: serializedPlayers,
    board: this.board.serialize()
  });
}

GameData.prototype.getPlayerById = function(id) {
  for (let i = 0; i < this.players.length; i++) {
    if (this.players[i].number == id) {
      return this.players[i];
    }
  }
  return false;
}

// Testing

const settings = {
  numberOfPlayers: 2,
  players: [
    { number: 1, type: "player"},
    { number: 2, type: "player"},
    { number: 3, type: "observer"}
  ]
}

var my_game = new GameData();