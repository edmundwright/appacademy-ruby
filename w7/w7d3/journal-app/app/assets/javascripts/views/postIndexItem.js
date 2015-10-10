JournalApp.Views.PostIndexItem = Backbone.View.extend({
  events: {
    "click .delete-button": "delete"
  },

  template: JST['postIndexItem'],

  tagName: "li",

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  delete: function() {
    this.model.destroy();
  }
})
