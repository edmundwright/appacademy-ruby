$.Thumbnail = function (el) {
  this.$el = $(el);
  this.$imgs = this.$el.find('.gutter-images > img');
  this.$activeImg = this.$imgs.eq(0)
  this.activate(this.$activeImg);
  this.setHandlers();
  this.gutterIdx = 0;
  this.fillGutterImages();
}

$.Thumbnail.prototype.fillGutterImages = function () {
  this.$el.find('.gutter-images').text("");
  for (var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
    this.$el.find('.gutter-images').append(this.$imgs.eq(i))
  }
}

$.Thumbnail.prototype.activate = function ($img) {
  this.$el.find('main').text("");

  this.$el.find('main').append($img.clone());
};

$.Thumbnail.prototype.setHandlers = function () {
  this.$el.find('.gutter-images').on('click', 'img', function(e) {
    this.$activeImg =  $(e.currentTarget);
    this.activate(this.$activeImg)
  }.bind(this));

  this.$el.find('.gutter-images').on('mouseenter', 'img', function(e) {
    this.activate($(e.currentTarget));
  }.bind(this));

  this.$el.find('.gutter-images').on('mouseleave', 'img', function(e) {
    this.activate(this.$activeImg)
  }.bind(this));

};



$.fn.thumbnails = function () {
  return this.each(function () {
    return  new $.Thumbnail(this);
  });
}
