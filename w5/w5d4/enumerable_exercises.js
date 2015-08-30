require ("./array_exercises")

Array.prototype.myEach = function(funct) {
  for (var i = 0; i < this.length; i++) {
    funct(this[i]);
  }
  return this;
};

Array.prototype.myMap = function(funct) {
  var result = [];

  this.myEach(function(input) {
    result.push(funct(input));
  });

  return result;
};

Array.prototype.myInject = function(funct) {
  var result = null;

  this.myEach(function(input) {
    if (result === null) {
      result = input;
    } else {
      result = funct(result, input);
    }
  });

  return result;
};

Array.prototype.bubbleSort = function() {
var swapped, i, j, oldI;

  do {
    swapped = false;
    for ( i = 0; i < this.length - 1; i++) {
      for ( j = i + 1; j < this.length; j++) {
        if (this[i] > this[j]) {
          swapped = true;
           oldI = this[i];
          this[i] = this[j];
          this[j] = oldI;
        }
      };
    };
  } while (swapped);
  return this;
};

String.prototype.mySubstrings = function() {
  result = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = 1; i + j < this.length + 1; j++) {
      result.push(this.substr(i, j));
    };
  };

  return result.uniq();
};

var y = function(input) {
  console.log(input);
};

var z = function(input) {
  return input * 2;
};

var x = function(acc, el) {
  return acc * el;
};

[1,2,3].myEach(y);
console.log([1,2,3].myMap(z));
console.log([1,2,3].myInject(x));
console.log([2,3,1].bubbleSort());
console.log("catcat".mySubstrings());
