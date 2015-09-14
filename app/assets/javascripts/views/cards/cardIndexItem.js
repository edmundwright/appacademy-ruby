TrelloClone.Views.CardIndexItem = Backbone.CompositeView.extend({
  template: JST["cards/cardIndexItem"],

  tagName: "li",

  className: "card",

  events: {
    "click": "show"
  },

  render: function () {
    this.$el.attr("id", "card_" + this.model.id);
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    return this;
  },

  show: function () {
    // this.addSubview($("#modal"), new TrelloClone.Views.CardShow({
    //   model: this.model
    // }))
    Backbone.history.navigate("#cards/" + this.model.id, { trigger: true })
  }
});
