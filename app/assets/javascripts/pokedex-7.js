Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit .new-pokemon": "savePokemon"
  },

  render: function () {
    this.$el.html(JST["pokemonForm"]({}));
    $("#pokedex .pokemon-form").html(this.$el);
  },

  savePokemon: function (event) {
    var that = this;
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    this.model.save(formData.pokemon, {
      success: function () {
        that.collection.add(that.model);
        Backbone.history.navigate("/pokemon/" + that.model.get("id"), {trigger: true});
      }
    });
  }
  
});
