TrelloClone.Views.ListIndexItem = Backbone.CompositeView.extend({
  template: JST["lists/listIndexItem"],

  tagName: "li",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  events: {
    "click button.card-new": "cardNew"
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    this.addSubview("div.cards-div", new TrelloClone.Views.CardIndex({
      collection: this.model.cards()
    }))

    return this;
  },

  cardNew: function () {
    this.addSubview("div.card-new", new TrelloClone.Views.CardNew({
      list: this.model
    }));
  }
});
