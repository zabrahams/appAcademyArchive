Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  if (!pokemon.save( {}, {
    success: function () {
      that.pokes.add(pokemon);
      that.addPokemonToList(pokemon);
      callback(pokemon);
    }
  })) {
    console.log(pokemon.validationError);
    console.log(pokemon);
  }
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();

  var pokeAttrs = $(event.currentTarget).serializeJSON();
  console.log(pokeAttrs);
  this.createPokemon(pokeAttrs.pokemon, this.renderPokemonDetail.bind(this));

};
