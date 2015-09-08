Pokedex.Views.PokemonIndex = Backbone.View.extend({

  initialize: function() {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addPokemonToList);
  },

  events: {
    "click li": "selectPokemonFromList"
  },

  render: function() {
    this.$el.empty();
    this.collection.forEach(function(poke){
      this.addPokemonToList(poke);
    }.bind(this));
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST['pokemonListItem']({ pokemon: pokemon }));
  },

  refreshPokemon: function (callback) {
    var indexView = this;

    this.collection.fetch({ success: function () {
      indexView.collection.each(function (poke) {
        indexView.addPokemonToList(poke);
      });
      if (callback) { callback() };
    }});
  },

  selectPokemonFromList: function (e) {
    var $currentTarget = $(e.currentTarget);
    var id = $currentTarget.data('id');
    Backbone.history.navigate('pokemon/' + id, {trigger: true});

  }
})
