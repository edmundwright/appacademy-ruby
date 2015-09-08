Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemonDetail'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function() {
    this.$el.html(this.template({pokemon: this.model}))
    var $ul = this.$el.find("ul.toys");
    this.model.toys().forEach(function (toy) {
      $ul.append(JST['toyListItem']({ toy: toy }));
    })
  }
});
