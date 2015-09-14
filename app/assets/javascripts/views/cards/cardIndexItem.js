TrelloClone.Views.CardIndexItem = Backbone.View.extend({
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
    Backbone.history.navigate("#cards/" + this.model.id, { trigger: true })
  }
});
