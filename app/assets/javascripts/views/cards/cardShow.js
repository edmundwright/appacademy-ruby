TrelloClone.Views.CardShow = Backbone.View.extend({
  template: JST["cards/cardShow"],

  tagName: "li",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    // this.model.get(cards).each(function (card) {
    //   this.addSubview("ul.cards", new TrelloClone.Views.CardShow({
    //     model: card
    //   }))
    // })

    return this;
  }
});
