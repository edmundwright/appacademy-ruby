NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  tagName: "li",

  template: JST['feeds/feedIndexItem'],

  events: {
    "click button.delete": "delete"
  },

  render: function() {
    var itemTemplate = this.template({ feed: this.model });
    this.$el.html(itemTemplate);
    return this
  },

  delete: function() {
    this.model.destroy();
    this.remove();
  }
});
