Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: "/pokemon",

  toys: function () {
    return this._toys = this._toys || new Pokedex.Collections.Toys();
  },

  parse: function(jsonResp){
    if(jsonResp.toys){
      this.toys().set(jsonResp.toys);
      delete jsonResp.toys;
    }
    return jsonResp;
  }
});
