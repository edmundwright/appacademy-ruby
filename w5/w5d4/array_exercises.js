Array.prototype.uniq = function() {
  var result = [];
  var i;

  for (i = 0; i < this.length; i++) {
    if (result.indexOf(this[i]) === -1) {
      result.push(this[i]);
    }
  }

  return result;
};

Array.prototype.twoSum = function() {
  var result = [];
  var i, j;

  for (i = 0; i < this.length - 1; i++) {
     for (j = 1; j + i < this.length; j++) {
         if (this[i] + this[i + j] === 0) {
           result.push([i, i + j]);
         }
     }
  }

  return result;
};

Array.prototype.myTranspose = function() {
  var result = [];
  var i, j;

  for (i = 0; i < this.length; i++) {
    for (j = 0; j < this[i].length; j++) {
      if (result[j] === undefined) {
        result[j] = [];
      }
      result[j].push(this[i][j]);
    }
  }

  return result;
};

module.exports.Array = Array;

console.log([-1, 0, 2, -2, 1].twoSum());
console.log( [[0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].myTranspose());
