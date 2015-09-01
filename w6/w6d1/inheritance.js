Function.prototype.inherits = function (SuperClass) {
  var Surrogate = function () {};
  Surrogate.prototype = SuperClass.prototype;
  this.prototype = new Surrogate();
}

var MovingObject  = function(speed) {
  this.speed = speed;
}

MovingObject.prototype.move = function() {
  console.log("I am moving.");
};

var Ship = function(name) {
  this.name = name;
}

Ship.inherits(MovingObject);

Ship.prototype.shoot = function() {
  console.log("I am shooting");
};

var Asteroid = function(size) {
  this.size = size;
}

Asteroid.inherits(MovingObject);

Asteroid.prototype.crash= function() {
  console.log("I am crashing");
};
