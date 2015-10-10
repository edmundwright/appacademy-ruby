Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.refreshPokemon();

    this.bindHandlers();
  },

  bindHandlers: function () {
    this.$pokeList.on("click", "li.poke-list-item",
                      this.clickPokemonHandler.bind(this));

    this.$pokeDetail.on("click", "li.toy-list-item",
                        this.clickToyHandler.bind(this));

    this.$newPoke.on('submit', this.submitPokemonForm.bind(this));

    this.$toyDetail.on("change", "select", this.pokemonSelectHandler.bind(this));
  },

  clickPokemonHandler: function(e) {
    var id = $(e.currentTarget).data("id");
    var pokemon = this.pokemon.get(id);
    this.renderPokemonDetail(pokemon);
  },

  clickToyHandler: function(e) {
    var toyId= $(e.currentTarget).data("id");
    var pokemonId = $(e.currentTarget).data("pokemon-id");
    var toy = this.pokemon.get(pokemonId).toys().get(toyId);
    this.renderToyDetail(toy);
  },

  addPokemonToList: function (pokemon) {
    var $li = $('<li>');
    $li.addClass("poke-list-item");
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

  pokemonSelectHandler: function(e) {
    var oldPokemon = this.pokemon.get($(e.currentTarget).data("pokemon-id"));
    var toy = oldPokemon.toys().get($(e.currentTarget).data("id"));
    var newPokemonId = $(e.currentTarget).val();
    toy.save({"pokemon_id": newPokemonId},{
      success: function(){
        oldPokemon.toys().remove(toy);
        this.renderToysList(oldPokemon.toys());
        this.$toyDetail.empty();
      }.bind(this)
    });
  },

  renderPokemonDetail: function(pokemon){
    var $div = $('<div>');
    $div.addClass("detail");

    var $img = $('<img>');
    $img.attr('src', pokemon.get("image_url"));
    $div.append($img);

    var $ul = $('<ul>');
    _.each(pokemon.attributes, function (attributeVal, attributeKey) {
      var $li = $("<li>");
      $li.text(attributeKey + ': ' + attributeVal);
      $ul.append($li);
    });
    $div.append($ul);

    var $ultoys = $('<ul>');
    $ultoys.addClass("toys");
    this.$pokeDetail.html($div).append($ultoys);

    pokemon.fetch({
      success: function () {
        this.renderToysList(pokemon.toys());
      }.bind(this)
    })
  },

  renderToysList: function (toys) {
    this.$pokeDetail.find(".toys").empty();
    toys.forEach(this.addToyTolist.bind(this));
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
    $li = $('<li>');
    $li.addClass("toy-list-item");
    $li.html('Name: ' + toy.get("name") + ', Happiness: ' +
             toy.get("happiness") + ', Price: ' + toy.get("price"));
    $li.data("id", toy.id);
    $li.data("pokemon-id", toy.get("pokemon_id"));
    this.$pokeDetail.find("ul.toys").append($li);
  },

  renderToyDetail: function(toy){
    var $div = $('<div>');
    $div.addClass("detail");

    var $img = $('<img>');
    $img.attr('src', toy.get("image_url"));
    $div.append($img);

    var $ul = $('<ul>');
    _.each(toy.attributes, function (attributeVal, attributeKey) {
      $li = $("<li>")
      $li.text(attributeKey + ': ' + attributeVal);
      $ul.append($li);
    });
    $div.append($ul);

    var $select = $('<select>');
    $select.data("pokemon-id", toy.get("pokemon_id"));
    $select.data("id", toy.id);

    this.pokemon.forEach(function (individualPokemon) {
      $option = $('<option>');
      $option.val(individualPokemon.id);
      $option.text(individualPokemon.get("name"));

      if (individualPokemon.id === toy.get("pokemon_id")) {
        $option.prop("selected", true);
      }

      $select.append($option);
    }.bind(this))

    this.$toyDetail.html($div).append($select);
  }
});
