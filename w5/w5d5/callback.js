
// clock

function Clock () {

}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.currentTime.getHours() +
  ":" + this.currentTime.getMinutes() +
  ":" + this.currentTime.getSeconds());
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  this.currentTime.setTime(this.currentTime.getTime() +  Clock.TICK);
  this.printTime();
};

var clock = new Clock();
// clock.run();


// addNumbers

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// var addNumbers = function (sum, numsLeft, completionCallback) {
//   if (numsLeft === 0) {
//     completionCallback(sum);
//     return;
//   }
//
//   reader.question("Next number?", function(numberString) {
//     var nextNumber = parseInt(numberString);
//     sum += nextNumber;
//     console.log("Current sum: " + sum);
//     numsLeft -= 1;
//     addNumbers(sum, numsLeft, completionCallback);
//   })
//
// };
//
// addNumbers(10, 3, function (sum) {
//   console.log("Total Sum: " + sum);
//   reader.close();
// });

// absurdBubbleSort

var askIfGreaterThan = function (el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + " ?", function(input) {
    callback(input === "yes");
  })
};

var innerBubbleSortLoop = function (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i === (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
    return;
  }

  askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
    if (isGreaterThan) {
      var temp = arr[i];
      arr[i] = arr[i + 1];
      arr[i + 1] = temp;
      madeAnySwaps = true;
    }

    innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
  });
};

var absurdBubbleSort = function (arr, sortCompletionCallback) {
  var outerBubbleSortLoop = function (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    };
  };

  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 2, 1], function(arr) {
  console.log("Here is your sorted array: " + arr);
  reader.close();
});
