TrelloClone.Views.ListNew = Backbone.View.extend({
  events: {
    "click button.open": "open",
    "submit form": "submit",
    "click button.close": "close"
  },

  initialize: function (options) {
    this.isOpen = false;
    this.template = JST["lists/listNew"],
    this.board = options.board;
  },

  render: function () {
    this.$el.html(this.template({
      board: this.board,
      isOpen: this.isOpen
    }));

    return this;
  },

  open: function () {
    this.isOpen = true;
    this.render();
    this.$("input").focus();
  },

  close: function () {
    this.isOpen = false;
    this.render();
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var model = new TrelloClone.Models.List();
    model.save(jQuery.extend(formContent.list, {
      "ord": this.board.lists().length
    }), {
      success: function () {
        this.board.lists().add(model);
        this.close();
      }.bind(this)
    })
  }
});
