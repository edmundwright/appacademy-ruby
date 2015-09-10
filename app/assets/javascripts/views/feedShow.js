NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["feeds/feedShow"],

  events: {
    "click button.refresh": "refresh"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function() {
    this.$el.html(this.template({ feed: this.model }));
    this.model.entries().each(function(entry) {
      var entryView = new NewsReader.Views.FeedShowItem({ model: entry });
      this.addSubview("ul", entryView);
    }.bind(this));
    return this;
  },

  refresh: function() {
    this.model.fetch();
  }
});
