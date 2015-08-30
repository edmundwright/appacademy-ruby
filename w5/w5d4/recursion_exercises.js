"use strict";

var range = function(start,end) {
  if (start === end) {
    return [start];
  } else if (start > end) {
    return [];
  }
  else {
    return range(start, end - 1).concat(end);
  }
};

Array.prototype.mySum = function() {
  if (this.length === 0){
    return 0;
  } else {
    return this.slice(0, -1).mySum() + this[this.length - 1];
  }
};

var exp1 = function(b, n) {
  if (n === 0) {
    return 1;
  } else {
    return b * exp1(b, n - 1);
  }
};

var exp2 = function(b, n) {
  switch(n) {
    case 0:
      return 1;
    case 1:
      return b;
    default:
      if (n % 2 === 0) {
        var squareRoot = exp2(b, n / 2);
        return squareRoot * squareRoot;
      } else {
        var squareRoot = exp2(b, (n - 1) / 2);
        return b * squareRoot * squareRoot;
      }
  }
};

var fib = function(n) {
  var prevFibs,length;

  if (n < 3) {
    return [0, 1].slice(0, n);
  } else {
    prevFibs = fib(n -1);
    length = prevFibs.length;
    return prevFibs.concat(prevFibs[length - 1] + prevFibs[length- 2]);
  }
};

Array.prototype.bsearch = function(target) {
  var middleIndex, rightResult;
  if (this.length === 0) {
    return -1;
  }

  middleIndex = Math.floor(this.length / 2);
  if (target > this[middleIndex]) {
    rightResult = this.slice(middleIndex + 1).bsearch(target)
    if (rightResult === -1) {
      return -1;
    }
    return rightResult + middleIndex + 1;
  } else if (target === this[middleIndex]) {
    return middleIndex;
  } else {
    return this.slice(0,middleIndex).bsearch(target);
  }
};

var makeChange = function(target, coinValues) {
  var valueIndex, thisResult, maxValue, remainingCoinValues, recResult;

  var minValue = coinValues[coinValues.length - 1];

  if (target === 0) {
    return [];
  } else if (target < minValue) {
    return null;
  }

  var bestResult = null;

  for (valueIndex = 0; valueIndex < coinValues.length; valueIndex++) {
    remainingCoinValues = coinValues.slice(valueIndex);
    maxValue = remainingCoinValues[0];

    if (target >= maxValue) {
      recResult = makeChange(target - maxValue, remainingCoinValues);

      if (recResult === null) {
        thisResult = null;
      } else {
        thisResult = recResult.concat(maxValue);
      }

      if (thisResult !== null) {
        if (bestResult=== null || bestResult.length > thisResult.length) {
          bestResult = thisResult;
        }
      }
    }
  };

  return bestResult;
};

var merge = function(array1, array2) {
  var result = [];
  while (array1.length > 0 && array2.length > 0) {
    if (array1[0] < array2[0]) {
      result.push(array1.shift());
    } else {
      result.push(array2.shift());
    }
  }
  return result.concat(array1).concat(array2);
}

Array.prototype.mergeSort = function() {
  if (this.length < 2) {
    return this;
  }

  var middleIndex = Math.floor(this.length / 2);
  var sortedFirstHalf = this.slice(0, middleIndex).mergeSort();
  var sortedSecondHalf = this.slice(middleIndex).mergeSort();
  return merge(sortedFirstHalf, sortedSecondHalf);
};

Array.prototype.mySubsets = function() {
  if (this.length === 0) {
    return [[]];
  }

  console.log(this.slice(0, this.length - 1));
  var recSubsets = this.slice(0, this.length - 1).mySubsets();

  var result = [];

  for (var subSetIndex = 0; subSetIndex < recSubsets.length; subSetIndex++) {
    result.push(recSubsets[subSetIndex].concat(this[this.length - 1]));
    result.push(recSubsets[subSetIndex]);
  }

  return result;
};

//console.log(range(3,7));
//console.log([1,2,3].mySum());
// console.log(exp2(2, 4));
// console.log(fib(5));
// console.log([2,3,4].bsearch(5))
// console.log([2,3,4].bsearch(2))
// console.log([2,3,4].bsearch(3))
// console.log([2,3,4].bsearch(4))
// console.log([2,3,4,234,999099].bsearch(999099))
console.log(makeChange(77, [50, 25, 10, 5, 1]));
console.log(makeChange(14, [10, 7, 1]));
console.log(makeChange(25, [10, 7, 8, 5, 1]));
console.log(makeChange(14, [13]));
console.log([1,2,3].mySubsets());
