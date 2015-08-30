Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};

var Cat = function (name) {
  this.name = name;
};

Cat.prototype.sayHi = function () {
  return "Hi, " + this.name + "!";
};

var Dog = function (name) {
  this.name = name;
}

cat = new Cat("Gerald");
dog = new Dog("Ruby");

var boundSayHi = cat.sayHi.myBind(dog);

console.log(boundSayHi());
