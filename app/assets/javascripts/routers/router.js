NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.feeds = options.feeds;
    this.$el = options.$el;
  },

  routes: {
    "": "index"
  },

  index: function () {
    this.feeds.fetch();
    var indexView = new NewsReader.Views.FeedsIndex({collection: this.feeds});
    this.$el.html(indexView.render().$el);
  }

});
