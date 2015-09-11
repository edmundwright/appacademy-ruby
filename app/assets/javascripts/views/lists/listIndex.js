TrelloClone.Views.ListIndex = Backbone.CompositeView.extend({
  template: JST["lists/listIndex"],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);

    this.collection.each(function (model) {
      this.addSubview("ul.lists", new TrelloClone.Views.ListIndexItem({
        model: model
      }))
    }.bind(this))

    return this;
  }
});
