TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  template: JST["lists/listShow"],

  tagName: "li",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
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
  }
});
