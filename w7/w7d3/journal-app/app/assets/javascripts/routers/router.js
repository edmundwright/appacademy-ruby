JournalApp.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root",
    "posts/new": "postNew",
    "posts/:id/edit": "postEdit",
    "posts/:id": "postShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this._collection = new JournalApp.Collections.Posts();
    this._collection.fetch({ reset: true });
    var view = new JournalApp.Views.PostIndex({collection: this._collection});
    this.$rootEl.find("section.sidebar").html(view.render().$el);
  },

  postShow: function (id) {
    var model = this._collection.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({ model: model });
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.find("section.content").html(newView.render().$el);
  },

  postEdit: function(id) {
    this.postEditOrNew(this._collection.getOrFetch(id));
  },

  postNew: function() {
    this.postEditOrNew(new JournalApp.Models.Post());
  },

  postEditOrNew: function(model) {
    var view = new JournalApp.Views.PostForm({ model: model, collection: this._collection});
    this._swapView(view);
  },

  root: function() {
    this._currentView && this._currentView.remove();
    this._currentView = null;
  }
});
