(function() {
  window.SnakeGame = window.SnakeGame || {};

  var View = SnakeGame.View = function($el){
      this.board = new SnakeGame.Board(10, 10);
      this.$el = $el;
      this.setupListeners();

      setInterval(function(){
        this.board.snake.move();
        this.$el.text(this.board.render());
      }.bind(this), 500)
  }

  View.prototype.setupListeners = function () {
    $(document).on("keydown", function (e){
      var keyCode = e.keyCode;
      if (keyCode===38) {
        var dir = "N";
      } else if (keyCode===40) {
        var dir = "S";
      } else if (keyCode===39) {
        var dir = "E";
      } else {
        var dir = "W";
      }
      this.board.snake.turn(dir);
    }.bind(this))
  };


})();
