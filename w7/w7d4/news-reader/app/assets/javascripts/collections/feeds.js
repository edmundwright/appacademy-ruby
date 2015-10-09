NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,

  url: "api/feeds",

  getOrFetch: function (id) {
    var model = this.get(id)

    if (model) {
      model.fetch();
    } else {
      model = new NewsReader.Models.Feed({ id: id })
      this.add(model);
      model.fetch({
        error: function () {
          this.remove(model)
        }.bind(this)
      });
    }

    return model;
  }
});
