TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/boardShow"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    this.model.lists().each(function (list) {
      this.addSubview("ul.lists", new TrelloClone.Views.ListShow({
        model: list
      }))
    }.bind(this))

    return this;
  }
});
