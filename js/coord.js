(function(){
  window.SnakeGame = window.SnakeGame || {};

  var Coord = SnakeGame.Coord = function (x, y) {
    this.x = x;
    this.y = y;
  }

  Coord.prototype.plus = function (dir) {
    switch (dir) {
      case "N":
        return new Coord(this.x, this.y - 1);
      case "S":
        return new Coord(this.x, this.y + 1);
      case "E":
        return new Coord(this.x + 1, this.y);
      case "W":
        return new Coord(this.x - 1, this.y);
    }
  };

  Coord.prototype.equals = function (otherCoord) {
    return this.x === otherCoord.x && this.y === otherCoord.y;
  };
})();
