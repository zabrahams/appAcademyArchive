window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: "/pokemon",
  toys: function () {
    if (typeof this._toys === "undefined") {
      this._toys = new Pokedex.Collections.PokemonToys();
    }
    return this._toys;
  },
  parse: function(payload) {
    if (payload.toys) {
      this.toys().set(payload.toys)
      delete payload.toys;
    }
    return payload;
  },
  validate: function(attributes) {
    if (!attributes || !attributes.name || attributes.name === "") {
      return "cannot have an empty name";
    }
    if (!attributes || !attributes.poke_type || attributes.poke_type === "") {
      return "cannot have an empty poke_type";
    }
    if (!attributes || !attributes.image_url || attributes.image_url === "") {
      return "cannot have an empty image_url";
    }
    if (!attributes || !attributes.attack || attributes.attack === "") {
      return "cannot have an empty attack";
    }
    if (!attributes || !attributes.defense || attributes.defense === "") {
      return "cannot have an empty defense";
    }
    if (!attributes || !attributes.moves || attributes.moves.length === 0) {
      return "cannot have an empty moves";
    }
  }
});

Pokedex.Models.Toy = Backbone.Model.extend({});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  url: "/pokemon",
  model: Pokedex.Models.Pokemon
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({});

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  // Click handlers go here.
  this.$pokeList.on("click", "li", this.selectPokemonFromList.bind(this));
  this.$newPoke.on("submit", this.submitPokemonForm.bind(this));
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
