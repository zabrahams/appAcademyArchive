Pokedex.RootView.prototype.reassignToy = function(event){
  var oldId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  var newId = $(event.currentTarget).val();

  var poke = this.pokes.get(oldId);
  var toy = poke.toys().get(toyId);
  toy.set("pokemon_id", newId);
  var that = this;
  toy.save({}, {
    success: function(toy){
      that.pokes.remove(toy);
      that.renderPokemonDetail(poke);
      that.$toyDetail.empty();
    }
  });
};



Pokedex.RootView.prototype.renderToysList = function (toys) {
  var that = this;
  this.$pokeDetail.find(".toys").empty();
  toys.forEach ( function (toy) {
    that.addToyToList(toy);
  })
};
