(function(){
  window.SnakeGame = window.SnakeGame || {};


  var Snake = SnakeGame.Snake = function () {
    this.dir = Snake.DEFAULTDIR;
    this.segments = Snake.DEFAULTSEG;
  }

  Snake.DEFAULTDIR = "S"
  Snake.DEFAULTSEG = [new SnakeGame.Coord(0, 0), new SnakeGame.Coord(0, 1)]


  Snake.prototype.move = function () {
    this.segments.pop();
    this.segments.unshift(this.segments[0].plus(this.dir));
  }

  Snake.prototype.turn = function(newDir) {
    this.dir = newDir;
  }


})();
