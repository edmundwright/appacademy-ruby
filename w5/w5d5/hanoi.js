var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.prototype.isWon = function() {
  return this.stacks[1].length === 3 || this.stacks[2].length === 3;
};

HanoiGame.prototype.isValidMove = function(start, end) {
  return start.length !== 0 && (
    end.length === 0 || end[end.length - 1] > start[start.length - 1]
  );
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  var start = this.stacks[startTowerIdx];
  var end = this.stacks[endTowerIdx];
  console.log(startTowerIdx);
  if (this.isValidMove(start, end)) {
    end.push(start.pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  for (var i = 0; i < this.stacks.length; i++) {
    console.log("stack " + i + ": " + this.stacks[i]);
  }
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  reader.question("Start pile", function (startIndexString) {
    var startIndex = parseInt(startIndexString);
    reader.question("End pile", function (endIndexString) {
      var endIndex = parseInt(endIndexString);
      callback(startIndex, endIndex);
    });
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  this.promptMove(function (startIndex, endIndex) {
    if (this.move(startIndex, endIndex)) {
      if (this.isWon()) {
        completionCallback();
      } else {
        this.run(completionCallback);
      }
    } else {
      console.log("Invalid Move");
      this.run(completionCallback);
    }
  }.bind(this));
};

var game = new HanoiGame();

game.run(function () {
  console.log("You've won!");
  reader.close();
});
