var Board = function () {
  this.grid = [[null, null, null], [null, null, null], [null, null, null]];
};

Board.prototype.addMark = function(pos, mark) {
  if (pos[0] < 0 || pos[1] < 0 || pos[0] > 2 || pos[1] > 2) {
    return false;
  }
  if (this.grid[pos[0]][pos[1]] === null) {
    this.grid[pos[0]][pos[1]] = mark;
    return true;
  } else {
    return false;
  }
};

Board.prototype.markHasWon = function (mark) {
  var lines = this.rows().concat(this.columns()).concat(this.diagonals());

  for (var i = 0; i < lines.length; i++) {

    if (lines[i].every(function (square) {
      return (square === mark);
     })) {
       return true;
     }
  };

  return false;
};

Board.prototype.columns = function () {
  var result = [[], [], []]
  for (var rowI = 0; rowI < this.grid.length; rowI++) {
    for (var colI = 0; colI < this.grid.length; colI++) {
      result[colI].push(this.grid[rowI][colI]);
    }
  }
  return result;
};

Board.prototype.diagonals = function () {
  return [[this.grid[0][0], this.grid[1][1], this.grid[2][2]],
          [this.grid[0][2], this.grid[1][1], this.grid[2][0]]];
};

Board.prototype.rows = function () {
  return this.grid;
};

Board.prototype.render = function () {
  this.rows().forEach(function (row) {
    console.log(row);
  })
};

module.exports = Board;
