TrelloClone.Views.BoardIndex = Backbone.CompositeView.extend({
  template: JST["boards/boardIndex"],
  
  initialize: function () {
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);

    this.collection.each(function (model) {
      this.addSubview("ul", new TrelloClone.Views.BoardIndexItem({
        model: model
      }))
    }.bind(this))

    return this;
  }
});
