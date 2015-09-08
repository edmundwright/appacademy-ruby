Pokedex.Views.PokemonIndex = Backbone.View.extend({

  initialize: function() {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addPokemonToList);
  },

  render: function() {
    this.$el.empty();
    this.collection.forEach(function(poke){
      this.addPokemonToList(poke);
    }.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var $li = $("<li class='poke-list-item'>");
    $li.data('id', pokemon.escape('id'));

    $li.html(JST['pokemonListItem']({ pokemon: pokemon }));

    this.$el.append($li);
  },

  refreshPokemon: function () {
    var that = this;

    this.collection.fetch({ success: function () {
      that.collection.each(function (poke) {
        that.addPokemonToList(poke);
      });
    }});
  }
})
