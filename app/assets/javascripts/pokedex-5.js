Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  logStuff: function () {
    console.log("STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF STUFF");
  },

  addPokemonToList: function (pokemon) {
    var $content = $(JST["pokemonListItem"]({pokemon: pokemon}));
    $content.data("id", pokemon.get("id"));
    this.$el.append($content);
  },

  refreshPokemon: function (options, callback) {
    var that = this;
    that.collection.fetch({
      success: function () {
        callback && callback();
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

    Backbone.history.navigate("/pokemon/"+id, {trigger: true});

  }
});


Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options, callback) {
    var that = this;
    this.model && this.model.fetch({
      success: function () {
        that.render();
        callback && callback();
      }
    });
  },

  render: function () {
    var that = this;

    this.$el.html(JST["pokemonDetail"]({pokemon: this.model}));
    var toys = this.model.toys();

    var $ul = $(JST["toyList"]({}));
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
    var pokemonId = $target.data("pokemon-id");
    var toy = this.model.toys().get(toyId);

    Backbone.history.navigate("/pokemon/" + pokemonId + "/toys/" + toyId, {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.html(JST["toyDetail"]({toy: this.model}));
  }
});

// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
