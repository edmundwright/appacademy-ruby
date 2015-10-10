TrelloClone.Views.ItemIndex = Backbone.CompositeView.extend({
  template: JST["items/itemIndex"],

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);

    this.collection.each(function (model) {
      this.addSubview("ul", new TrelloClone.Views.ItemIndexItem({
        model: model
      }))
    }.bind(this))

    return this;
  }
});
