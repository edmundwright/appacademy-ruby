$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeArticle = this.$contentTabs.find('.active');
  this.$activeLink = this.$el.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (e) {
  e.preventDefault();

  this.$activeLink.removeClass('active');

  this.$activeLink = $(e.currentTarget);
  this.$activeLink.addClass('active');

  this.$activeArticle.removeClass('active').addClass('transitioning');

  this.$contentTabs.one('transitionend', function () {
    this.$activeArticle.removeClass('transitioning');

    this.$activeArticle = this.$contentTabs.find(this.$activeLink.attr("href"));
    this.$activeArticle.addClass('active transitioning');

    setTimeout(function () {
      this.$activeArticle.removeClass('transitioning');
    }.bind(this),0);
  }.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
