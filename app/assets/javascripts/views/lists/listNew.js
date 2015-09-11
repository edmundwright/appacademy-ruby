TrelloClone.Views.ListNew = Backbone.View.extend({
  events: {
    "click button.open": "open",
    "submit form": "submit",
    "click button.close": "close"
  },

  initialize: function (options) {
    this.formTemplate = JST["lists/listNewForm"],
    this.buttonTemplate = JST["lists/listNewButton"],
    this.currentTemplate = this.buttonTemplate;
    this.board = options.board;
  },

  render: function () {
    this.$el.html(this.currentTemplate({
      board: this.board
    }));

    return this;
  },

  open: function () {
    this.currentTemplate = this.formTemplate;
    this.render();
    this.$("input").focus();
  },

  close: function () {
    this.currentTemplate = this.buttonTemplate;
    this.render();
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var model = new TrelloClone.Models.List();
    model.save(formContent.list, {
      success: function () {
        this.board.lists().add(model);
        this.close();
      }.bind(this)
    })
  }
});
