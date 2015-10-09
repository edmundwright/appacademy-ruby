NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "feedIndex",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl
  },

  feedIndex: function () {
    var view = new NewsReader.Views.FeedIndex({
      collection: NewsReader.feeds
    });
    this._swapView(view);
  },

  feedShow: function (id) {
    var model = NewsReader.feeds.getOrFetch(id)
    debugger
    if (model) {
      var view = new NewsReader.Views.FeedShow({
        model: model
      });
      this._swapView(view);
    } else {
      Backbone.history.navigate("#", { trigger: true })
    }
  },

  _swapView: function(newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  },

  feedNew: function() {
    var view = new NewsReader.Views.FeedNew();
    this._swapView(view);
  }
});
