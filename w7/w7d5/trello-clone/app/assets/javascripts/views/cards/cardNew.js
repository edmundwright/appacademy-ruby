TrelloClone.Views.CardNew = Backbone.View.extend({
  template: JST["cards/cardNew"],

  events: {
    "submit form": "submit",
    "click button.close": "close",
    "click button.open": "open"
  },

  initialize: function (options) {
    this.isOpen = false;
    this.list = options.list
  },

  render: function () {
    this.$el.html(this.template({
      isOpen: this.isOpen,
      list: this.list
    }));

    return this;
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var model = new TrelloClone.Models.Card();
    model.save(jQuery.extend(formContent.card, {
      "ord": this.list.cards().length
    }), {
      success: function () {
        this.list.cards().add(model);
        this.close();
      }.bind(this)
    })
  },

  open: function () {
    this.isOpen = true;
    this.render();
    this.$("textarea").focus();
  },

  close: function () {
    this.isOpen = false;
    this.render();
  }
});
