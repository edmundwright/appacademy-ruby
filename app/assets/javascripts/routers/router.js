JournalApp.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "postIndex",
    "posts/": "postIndex",
    "posts/:id": "postShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this._collection = new JournalApp.Collections.Posts();
  },

  postIndex: function () {
    this._collection.fetch();
    var view = new JournalApp.Views.PostIndex({collection: this._collection});
    this._swapView(view);
  },

  postShow: function (id) {
    var model = this._collection.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({ model: model });
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});
