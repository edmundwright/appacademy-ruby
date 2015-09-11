TrelloClone.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "boardIndex",
    "boards/new": "boardNew",
    "boards/:id": "boardShow",
    "cards/:id": "cardShow"
  },

  boardNew: function () {
    var view = new TrelloClone.Views.BoardNew()

    this._swapView(view);
  },

  boardIndex: function () {
    var view = new TrelloClone.Views.BoardIndex({
      collection: TrelloClone.boards
    })

    this._swapView(view);
  },

  boardShow: function (id) {
    var model = TrelloClone.boards.getOrFetch(id);
    var view = new TrelloClone.Views.BoardShow({
      model: model
    });

    this._swapView(view);
  },

  cardShow: function (id) {
    var model = new TrelloClone.Models.Card({
      id: id
    });
    var view = new TrelloClone.Views.CardShow({
      model: model
    });

    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});
