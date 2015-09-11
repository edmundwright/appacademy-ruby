TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  template: JST["boards/boardIndexItem"],

  tagname: "li",

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    return this;
  }
});
