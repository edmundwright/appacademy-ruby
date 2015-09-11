TrelloClone.Views.CardIndex = Backbone.CompositeView.extend({
  template: JST["cards/cardIndex"],

  initialize: function () {
    this.collection.fetch();
  },

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);

    this.collection.each(function (model) {
      this.addSubview("ul", new TrelloClone.Views.CardIndexItem({
        model: model
      }))
    }.bind(this))

    return this;
  }
});
