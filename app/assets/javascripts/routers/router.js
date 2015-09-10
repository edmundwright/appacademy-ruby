NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "feedIndex"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl
  },

  feedIndex: function () {
    var view = new NewsReader.Views.FeedIndex({
      collection: NewsReader.feeds
    });
    this.$rootEl.html(view.render().$el);
    NewsReader.feeds.fetch();
  }
});
