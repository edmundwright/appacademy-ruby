Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST['toyDetail'],

  render: function () {
    this.$el.html(this.template({ toy: this.model, pokes: [] }));
  }
});
