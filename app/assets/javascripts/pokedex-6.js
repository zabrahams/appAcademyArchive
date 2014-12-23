Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonID/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    this._pokemonIndex || this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    var pokemon = this._pokemonIndex.collection.get(id);
    var pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});

    if (this._pokemonDetail) {
      this._pokemonDetail.remove();
    }

    this._pokemonDetail = pokemonDetail;

    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    pokemonDetail.refreshPokemon({}, callback);
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({}, callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
    // this._pokemonIndex || this.pokemonIndex(this.toyDetail.bind(this, pokemonId, toyId))
    this._pokemonDetail || this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    var pokemon = this._pokemonDetail.model;
      console.log(this._pokemonDetail);
    if (pokemon !== undefined && pokemon.toys() !== undefined) {
      console.log(pokemon);
      console.log(pokemon.toys());
      var toy = pokemon.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(toyDetail.$el);
      toyDetail.render();
    }
  },

  pokemonForm: function () {
  }
});

$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
