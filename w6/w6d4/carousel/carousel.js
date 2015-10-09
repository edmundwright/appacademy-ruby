$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$lis = this.$el.find('.items > li');
  this.$lis.eq(0).addClass('active');
  this.$lis.eq(this.$lis.length - 1).addClass('left');
  this.$lis.eq(1).addClass('right');

  this.setupHandlers();
};

$.Carousel.prototype.setupHandlers = function () {
  this.$el.on('click', '.slide-left', this.slideLeft.bind(this))
  this.$el.on('click', '.slide-right', this.slideRight.bind(this))

};

$.Carousel.prototype.slideLeft = function () { this.slide(-1) };
$.Carousel.prototype.slideRight = function () { this.slide(1) };

$.Carousel.prototype.slide = function (dir) {
  this.$lis.removeClass('active');
  this.$lis.removeClass('right');
  this.$lis.removeClass('left');

  this.activeIdx = this.wrap(this.activeIdx + dir);

  var rightIdx = this.wrap(this.activeIdx + 1);
  var leftIdx = this.wrap(this.activeIdx - 1);

  console.log(this.activeIdx)
  this.$lis.eq(this.activeIdx).addClass('active');
  this.$lis.eq(rightIdx).addClass('right');
  this.$lis.eq(leftIdx).addClass('left');
};

$.Carousel.prototype.wrap = function (num) {
  return (num === -1) ? this.$lis.length -1 : (num % this.$lis.length)
};

$.fn.carousels = function () {
  return this.each(function () {
    new $.Carousel(this)
  });
};
