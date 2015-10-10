(function() {
  window.SnakeGame = window.SnakeGame || {};

  var Board = SnakeGame.Board = function(width, height){
    this.width = width;
    this.height = height;
    this.snake = new SnakeGame.Snake();
  }

  Board.prototype.render = function () {
    var result = "";
    for (var i = 0; i < this.height; i++ ) {
      for (var j = 0; j < this.width; j++ ) {
        var currentCoord = new SnakeGame.Coord(j, i);
         var segmentHere = this.snake.segments.some(function (segment) {
          return segment.equals(currentCoord);
        })
        result += (segmentHere ? "S" : ".");
      }
      result += "\n";
    }
  return result;
  }


})();
