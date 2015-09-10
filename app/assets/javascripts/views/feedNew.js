NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST['feeds/feedNew'],

  events: {
    "submit form.feed-new": "feedNew"
  },

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  feedNew: function (e) {
    e.preventDefault();
    var formContent = $(e.currentTarget).serializeJSON();
    var feed = new NewsReader.Models.Feed();
    feed.save(formContent.feed, {
      success: function () {
        NewsReader.feeds.add(feed);
        Backbone.history.navigate("feeds/" + feed.id, { trigger: true })
      }
    });
  }
});
