Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.refreshPokemon();

    this.$pokeList.on("click", "li.poke-list-item", function(event){
      var id = $(event.currentTarget).data("id");
      var pokemon = this.pokemon.get(id);
      this.renderPokemonDetail(pokemon);
    }.bind(this));

    this.$newPoke.on('submit', this.submitPokemonForm.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var $li = $('<li class="poke-list-item"></li>');
    $li.html(pokemon.get("name") + " - " + pokemon.get("poke_type"));
    $li.data("id", pokemon.id);
    this.$pokeList.append($li);
  },

  refreshPokemon: function(){
    this.pokemon.fetch({
      success: function(){
        this.pokemon.forEach(this.addPokemonToList.bind(this));
      }.bind(this)
    });
  },

  renderPokemonDetail: function(pokemon){
    var $div = $('<div class="detail"></div>');
    var $img = $('<img src="'+ pokemon.get("image_url") +'">');
    $div.append($img);
    var $ul = $('<ul></ul>');
    _.each(pokemon.attributes, function (attributeVal, attributeKey) {
      $ul.append('<li>' + attributeKey + ': ' + attributeVal + '</li>');
    });

    $div.append($ul);

    this.$pokeDetail.html($div);
  },

  createPokemon: function(attributes, callback){
    var pokemon = new Pokedex.Models.Pokemon(attributes);
    pokemon.save({},{
      success: function(){
        this.pokemon.add(pokemon);
        this.addPokemonToList(pokemon);
        callback(pokemon);
      }.bind(this),

      error: function(){
        console.log("ERRROOORR!");
      }
    });
  },

  submitPokemonForm: function(e){
    e.preventDefault();
    var formData = $(e.currentTarget).serializeJSON().pokemon;
    this.createPokemon(formData, this.renderPokemonDetail.bind(this));
  }
});
