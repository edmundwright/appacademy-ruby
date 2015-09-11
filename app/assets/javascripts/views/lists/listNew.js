TrelloClone.Views.ListNew = Backbone.View.extend({
  template: JST["lists/listNew"],

  events: {
    "submit form": "submit",
    "click button.close": "close"
  },

  initialize: function (options) {
    this.board = options.board
  },

  render: function () {
    this.$el.html(this.template({
      board: this.board
    }));

    return this;
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var model = new TrelloClone.Models.List();
    model.save(formContent.list, {
      success: function () {
        this.board.lists().add(model);
        this.remove();
      }.bind(this)
    })
  },

  close: function () {
    this.remove();
  }
});
