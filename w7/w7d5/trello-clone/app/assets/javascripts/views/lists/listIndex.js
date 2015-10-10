TrelloClone.Views.ListIndex = Backbone.CompositeView.extend({
  template: JST["lists/listIndex"],

  initialize: function () {
    this.listenTo(this.collection, "add", this.render);
  },

  events: {
    "sortbeforestop ul.lists": "updateOrder"
  },

  updateOrder: function () {
    var order = this.$("ul.lists").sortable( "toArray");
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
      this.addSubview("ul.lists", new TrelloClone.Views.ListIndexItem({
        model: model
      }))
    }.bind(this))

    this.$("ul.lists").sortable();

    return this;
  }
});
