TrelloClone.Views.CardIndex = Backbone.CompositeView.extend({
  template: JST["cards/cardIndex"],

  initialize: function () {
    this.listenTo(this.collection, "add", this.render)
  },

  events: {
    "sortbeforestop ul.cards": "updateOrder"
  },

  updateOrder: function () {
    var order = this.$("ul.cards").sortable( "toArray");
    for (var position = 0; position < order.length; position++) {
      var model = this.collection.get(order[position].slice(5));
      model.save({
        "ord": position
      });
    }
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
