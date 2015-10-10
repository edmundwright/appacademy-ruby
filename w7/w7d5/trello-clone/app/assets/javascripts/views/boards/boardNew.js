TrelloClone.Views.BoardNew = Backbone.View.extend({
  template: JST["boards/boardNew"],

  tagName: "form",

  events: {
    "click button": "submit"
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = this.$el.serializeJSON();
    var model = new TrelloClone.Models.Board();
    model.save(formContent.board, {
      success: function () {
        TrelloClone.boards.add(model);
        Backbone.history.navigate("boards/" + model.id, { trigger: true });
      }
    })
  }
});
