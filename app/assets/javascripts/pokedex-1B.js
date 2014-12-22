Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  $detail = $("<div></div>").addClass("detail");
  $detail.append("<img src='" + pokemon.get("image_url") + "'>");
  var props = ["name", "poke_type", "moves", "attack", "defense"];
  props.forEach ( function (prop) {
    var $deets = $("<div></div>").addClass(prop).append(prop + ": " + pokemon.get(prop)+ " ");
    $detail.append($deets);
  });

  this.$pokeDetail.html($detail);

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
