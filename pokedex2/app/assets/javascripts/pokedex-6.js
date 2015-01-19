Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonID/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex === undefined){
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    } else {
      var pokemon = this._pokemonIndex.collection.get(id);
      var pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});

      if (this._pokemonDetail) {
        this._pokemonDetail.remove();
      }

      this._pokemonDetail = pokemonDetail;

      $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
      pokemonDetail.refreshPokemon({}, callback);
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({}, callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (this._pokemonDetail === undefined){
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    } else {
      var pokemon = this._pokemonDetail.model;
      var toy = pokemon.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(toyDetail.$el);
      toyDetail.render();
    }
  },

  pokemonForm: function () {
    if (this._pokemonIndex === undefined) {
      this.pokemonIndex(this.pokemonForm);
    } else {
      var pokemonForm = new Pokedex.Views.PokemonForm({
        model: new Pokedex.Models.Pokemon(),
        collection: this._pokemonIndex.collection
      });
      pokemonForm.render();
    }
  }
});

$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
