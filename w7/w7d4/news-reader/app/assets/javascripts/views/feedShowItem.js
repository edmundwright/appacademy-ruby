NewsReader.Views.FeedShowItem = Backbone.View.extend({
  template: JST['feeds/feedShowItem'],

  tagName: "li",

  render: function() {
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }
});
