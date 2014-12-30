NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.feeds = options.feeds;
    this.$el = options.$el;
  },

  routes: {
    "": "feedIndex",
    "feeds/:id": "feedShow"
  },

  feedIndex: function () {
    this.feeds.fetch();
    var indexView = new NewsReader.Views.FeedsIndex({collection: this.feeds});
    this.swapView(indexView);
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    feed.fetch();
    var showView = new NewsReader.Views.FeedShow({model: feed});
    this.swapView(showView);
  },

  swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$el.html(newView.render().$el);
  }

});
