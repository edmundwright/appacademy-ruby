TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST["cards/cardShow"],


  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    this.addSubview("div.items-div", new TrelloClone.Views.ItemIndex({
      collection: this.model.items()
    }))

    return this;
  }
});
