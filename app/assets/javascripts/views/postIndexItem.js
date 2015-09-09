JournalApp.Views.PostIndexItem = Backbone.View.extend({
  template: JST['postIndexItem'],
  tagName: "li",
  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  }
})
