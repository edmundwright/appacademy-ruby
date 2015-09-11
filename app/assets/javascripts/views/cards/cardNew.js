TrelloClone.Views.CardNew = Backbone.View.extend({
  template: JST["cards/cardNew"],

  events: {
    "submit form": "submit",
    "click button.close": "close"
  },

  initialize: function (options) {
    this.list = options.list
  },

  render: function () {
    this.$el.html(this.template({
      list: this.list
    }));

    return this;
  },

  submit: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var model = new TrelloClone.Models.Card();
    model.save(formContent.card, {
      success: function () {
        this.list.cards().add(model);
        this.remove();
      }.bind(this)
    })
  },

  close: function () {
    this.remove();
  }
});
