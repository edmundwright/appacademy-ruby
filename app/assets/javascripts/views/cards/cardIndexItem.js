TrelloClone.Views.CardIndexItem = Backbone.View.extend({
  template: JST["cards/cardIndexItem"],

  tagname: "li",

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    return this;
  }
});
