TrelloClone.Views.CardIndex = Backbone.CompositeView.extend({
  template: JST["cards/cardIndex"],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);

    this.collection.each(function (model) {
      this.addSubview("ul.cards", new TrelloClone.Views.CardIndexItem({
        model: model
      }))
    }.bind(this))

    this.$("ul.cards").sortable();

    return this;
  }
});
