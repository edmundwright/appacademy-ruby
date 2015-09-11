TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/boardShow"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.list-new": "listNew"
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    this.addSubview("div.lists-div", new TrelloClone.Views.ListIndex({
      collection: this.model.lists()
    }));

    this.addSubview("div.list-new", new TrelloClone.Views.ListNew({
      board: this.model
    }));

    return this;
  },

  listNew: function () {
    this.addSubview("div.list-new", new TrelloClone.Views.ListNew({
      board: this.model
    }));
  }
});
