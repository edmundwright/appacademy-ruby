NewsReader.Views.FeedIndex = Backbone.CompositeView.extend({
  template: JST["feeds/feedIndex"],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template());
    this.collection.each(function(feed) {
      var indexItemView = new NewsReader.Views.FeedIndexItem({ model: feed });
      this.addSubview("ul", indexItemView);
    }.bind(this))

    return this;
  }
});
