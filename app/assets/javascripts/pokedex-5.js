Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var $content = $(JST["pokemonListItem"]({pokemon: pokemon}));
    $content.data("id", pokemon.get("id"));
    this.$el.append($content);
  },

  refreshPokemon: function (options) {
    var that = this;
    that.collection.fetch({
      success: function () {
        that.render();
      }
    })
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.forEach( function (pokemon) {
      that.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var id = $target.data("id");
    var pokemon = this.collection.get(id);
    var pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    pokemonDetail.refreshPokemon();
  }
});


Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
      }
    });
  },

  render: function () {
    var that = this;

    this.$el.html(JST["pokemonDetail"]({pokemon: this.model}));
    var toys = this.model.toys();

    var $ul = $("<ul class='toys'>");
    toys.forEach( function (toy) {
      var $content = $(JST["toyListItem"]({toy: toy}));
      $content.data("toy-id", toy.get("id"));
      $content.data("pokemon-id", that.model.get("id"));
      $ul.append($content);
    })
    this.$el.append($ul);
  },

  selectToyFromList: function (event) {
    var $target = $(event.currentTarget);
    var toyId = $target.data("toy-id");
    // var pokemonId = $target.data("pokemon-id");
    var toy = this.model.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
    $("#pokedex .toy-detail").html(toyDetail.$el);
    toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    console.log(this.model);
    this.$el.html(JST["toyDetail"]({toy: this.model}));
  }
});

$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
