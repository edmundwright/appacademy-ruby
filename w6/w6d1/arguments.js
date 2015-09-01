var sum = function() {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }

  return result;
};

Function.prototype.myBind = function() {
  var fn = this;
  var obj = arguments[0];
  var args = Array.prototype.slice.call(arguments, 1);

  return function() {
    var moreArgs = Array.prototype.slice.call(arguments);
    return fn.apply(obj, args.concat(moreArgs));
  };
};

function curriedSum(numArgs) {
  var numbers = [];

  function _curriedSum(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      result = 0;

      numbers.forEach(function (number) {
        result += number;
      })

      return result;
    } else {
      return _curriedSum;
    }
  };

  return _curriedSum;
};


Function.prototype.curry = function (numArgs) {
  var fn = this;
  var args = [];

  function _curry(arg) {
    args.push(arg);

    if (args.length === numArgs) {
      return fn.apply(null, args);
    } else {
      return _curry;
    }
  };

  return _curry;
};
