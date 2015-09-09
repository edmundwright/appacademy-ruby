JournalApp.Views.PostIndex = Backbone.View.extend({
  template: JST['postIndex'],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function(){
    var content = this.template({ posts: this.collection });
    this.$el.html(content);
    this.collection.forEach(function(model) {
      var $li = new JournalApp.Views.PostIndexItem({model: model}).render().$el
      this.$el.find("ul").append($li)
    }.bind(this))
    return this;
  }
});
