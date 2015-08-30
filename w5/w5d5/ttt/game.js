var Board = require("./board");

var Game = function (reader) {
  this.board = new Board();
  this.currentMark = "X";
  this.reader = reader;
};

Game.prototype.run = function (completionCallback) {
  this.board.render();
  this.reader.question("Enter row", function (rowString) {
    var rowIndex = parseInt(rowString);
    this.reader.question("Enter column", function (colString) {
      var colIndex = parseInt(colString);
      this.evaluateMove(rowIndex, colIndex, completionCallback);
    }.bind(this));
  }.bind(this));
};

Game.prototype.evaluateMove = function (rowIndex, colIndex, completionCallback) {
  if (this.board.addMark([rowIndex, colIndex], this.currentMark)) {
    if (this.board.markHasWon(this.currentMark)) {
      completionCallback(this.currentMark)
      return;
    }
    this.currentMark = this.currentMark === "X" ? "O" : "X";
    this.run(completionCallback);
  } else {
    console.log("Invalid Move");
    this.run(completionCallback);
  }
};

module.exports = Game;
