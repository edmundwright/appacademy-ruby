JournalApp.Views.PostShow = Backbone.View.extend({
  events: {
    "click button.delete": "delete"
  },

  template: JST["postShow"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  delete: function() {
    this.model.destroy();
    Backbone.history.navigate("", {trigger: true})
  }
});
