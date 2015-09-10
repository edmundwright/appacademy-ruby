NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  tagName: "li",

  template: JST['feeds/feedIndexItem'],

  render: function() {
    var itemTemplate = this.template({ feed: this.model });
    this.$el.html(itemTemplate);
    return this
  }
});
