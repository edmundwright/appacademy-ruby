Pokedex.Views.ToyDetail = Backbone.View.extend({
  initialize: function (options) {
    this.pokemonCollection = options.pokemonCollection;
  },

  events: {
    "change select": "reassignToy"
  },

  template: JST['toyDetail'],

  render: function () {
    this.$el.html(this.template({
      toy: this.model,
      pokes: this.pokemonCollection
    }));
  },

  reassignToy: function (e) {
    var $currentTarget = $(e.currentTarget);
    var oldPokeId = this.model.get("pokemon_id");
    this.model.save({"pokemon_id": $currentTarget.val()}, {
      success: function () {
        Backbone.history.navigate("pokemon/" + oldPokeId, { trigger: true });
      }
    })
  }
});
