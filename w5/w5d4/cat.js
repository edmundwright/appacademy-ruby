var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
};
mittens = new Cat("Mittens", "Sally");
fuzzy = new Cat("Fuzzy", "Andrew");

console.log(mittens.cuteStatement());
console.log(fuzzy.cuteStatement());


Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
};

console.log(mittens.cuteStatement());
console.log(fuzzy.cuteStatement());

Cat.prototype.meow = function() {
  return "meow";
};
console.log(mittens.meow());

fuzzy.meow = function() {
  return "woof";
}
console.log(mittens.meow());
console.log(fuzzy.meow());
