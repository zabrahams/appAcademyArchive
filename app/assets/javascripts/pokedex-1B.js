Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  $detail = $("<div></div>").addClass("detail");
  $detail.append("<img src='" + pokemon.escape("image_url") + "'>");
  var props = ["name", "poke_type", "moves", "attack", "defense"];
  props.forEach ( function (prop) {
    var $deets = $("<div></div>").addClass(prop).append(prop + ": " + pokemon.escape(prop)+ " ");
    $detail.append($deets);
  });
  var $ul = $("<ul class ='toys'></ul>")
  $detail.append($ul);

  var that = this;
  pokemon.fetch({
    success: function(pokemon){
      pokemon.toys().forEach (function(toy) {
        that.addToyToList.bind(that)(toy)
      })
    }
  });
  this.$pokeDetail.html($detail);

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data("id");
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};
