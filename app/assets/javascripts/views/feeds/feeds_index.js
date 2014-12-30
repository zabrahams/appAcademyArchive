NewsReader.Views.FeedsIndex = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  template: JST['feeds/index'],

  render: function () {
    this.$el.html(this.template( { feeds: this.collection } ));
    return this;
  }

});
