Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.refreshPokemon();

    this.$pokeList.on("click", "li.poke-list-item", function(e){
      var id = $(e.currentTarget).data("id");
      var pokemon = this.pokemon.get(id);
      this.renderPokemonDetail(pokemon);
    }.bind(this));

    this.$pokeDetail.on("click", "li.toy-list-item", function(e){
      var toyid= $(e.currentTarget).data("id");
      var pokemonid = $(e.currentTarget).data("pokemon-id");
      var pokemon = this.pokemon.get(pokemonid);
      var toy = pokemon.toys().get(toyid);
      this.renderToyDetail(toy);
    }.bind(this))

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
    var $ultoys = $('<ul class="toys"></ul>');
    this.$pokeDetail.html($div).append($ultoys);
    pokemon.fetch({
      success: function () {
        pokemon.toys().forEach(this.addToyTolist.bind(this));
      }.bind(this)
    })
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
  },

  addToyTolist: function (toy) {
    $li = $('<li class="toy-list-item"></li>');
    $li.html('Name: ' + toy.get("name") + ', Happiness: ' +
             toy.get("happiness") + ', Price: ' + toy.get("price"));
    $li.data("id", toy.id);
    $li.data("pokemon-id", toy.get("pokemon_id"));
    this.$pokeDetail.find("ul.toys").append($li);
  },

  renderToyDetail: function(toy){
    var $div = $('<div class="detail"></div>');

    var $img = $('<img src="'+ toy.get("image_url") +'">');
    $div.append($img);

    var $ul = $('<ul></ul>');
    _.each(toy.attributes, function (attributeVal, attributeKey) {
      $ul.append('<li>' + attributeKey + ': ' + attributeVal + '</li>');
    });

    $div.append($ul);

    this.$toyDetail.html($div);

  }
});
