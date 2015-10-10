TrelloClone.Views.ItemIndexItem = Backbone.View.extend({
  template: JST["items/itemIndexItem"],

  tagname: "li",

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);

    return this;
  }
});
