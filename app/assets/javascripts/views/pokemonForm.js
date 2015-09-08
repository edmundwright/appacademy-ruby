Pokedex.Views.PokemonForm = Backbone.View.extend({
  template: JST['pokemonForm'],

  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    this.$el.html(this.template({ pokemon: this.model }));
  },

  savePokemon: function (e) {
    e.preventDefault();
    var $currentTarget = $(e.currentTarget);
    var pokemonAttrs = $currentTarget.serializeJSON().pokemon;
    this.model.save(pokemonAttrs, {
      success: function(){
        this.collection.add(this.model);
        Backbone.history.navigate("pokemon/" + this.model.id, {trigger: true});
        this.model = new Pokedex.Models.Pokemon();
        this.render();
      }.bind(this)
    });
  }
});
