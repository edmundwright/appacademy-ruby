var add = function (a, b) {
  return a + b;
};

var addTen = add.bind(this, 10);
addTen(4); //=> 14


var curriedAdd = function (a) {
  return function (b) {
    return a + b;
  };
};

var addTenCurried = curriedAdd(10);
addTenCurried(4); //=> 14



// ARGUMENTS

var add = function (a, b) {
  console.log(arguments);
  console.log(typeof arguments);

  var args = Array.prototype.slice.call(arguments); //=> args array

  return a + b;
};


var obj = {
  "0": "a",
  "1": "b",
  "2": "c",
  length: 3
};


// var slice = function () {
//   var newArr = [];
//
//   for (var i = 0; i < this.length; i++) {
//     newArr.push(this[i]);
//   }
//
//   return newArr;
// }



// INHERITANCE

var Animal = function (colour) {
  this.colour = colour;
  this.mood = "happy";
};

Animal.prototype.breathe = function () {
  return "breathe";
};

var Cat = function (colour, name) {
  // this.colour = colour;
  // this.mood = "happy";

  // Animal(); //=> sets colour and mood on global obj
  Animal.call(this, colour); //=> sets colour and mood on Cat obj

  this.name = name;
};

function AnimalSurrogate() {};
AnimalSurrogate.prototype = Animal.prototype;
Cat.prototype = new AnimalSurrogate();

Cat.prototype.meow = function () {
  return "meow";
};


// 1) bad
// Cat.prototype = Animal.prototype;
// loses meow

// 2) also bad
// Cat.prototype = Animal.prototype;
//
// Cat.prototype.meow = function () {
//   return "meow";
// };
// messes with Animal prototype now

// 3) also not ideal, but closer
// // Cat.prototype = {
// //   __proto__: Animal.prototype
// // };
// // what we want ^
//
// Cat.prototype = new Animal("green");
// Cat.prototype = {
//   colour: "green",
//   __proto__: Animal.prototype
// };
// // unnecessary Animal

// 4)
function Surrogate() {};
// Surrogate.prototype === { __proto__: Object.prototype }
new Surrogate() //=> { __proto__: Surrogate.prototype }


function Surrogate() {};
Surrogate.prototype = Animal.prototype;
Cat.prototype = new Surrogate();
Moose.prototype = new Surrogate();

// Cat.prototype = Object.create(Animal.prototype);


Function.prototype.inherits = function (ParentClass) {

};

Cat.inherits(Animal);



// NAMESPACING

window.Asteroids = {};


// game.js
window.Asteroids = {};


// ship.js
window.Asteroids = {}; //=> overwrites game.js's Asteroids






window.Asteroids = window.Asteroids || {};

if (typeof window.Asteroids === 'undefined') {
  window.Asteroids = {};
}

window.Asteroids.Game = function () {

};

window.Asteroids.Game.prototype.run = function () {

};



// game.js
(function (root) {
  root.Asteroids = root.Asteroids || {};

  var Game = root.Asteroids.Game = function () {

  }; // triple assignment

  Game.SIZE = 300;

  Game.prototype.run = function () {

  };

  new Game() // this works
})(this);

new Game(); // does not work because outside of scope
new Asteroids.Game();
