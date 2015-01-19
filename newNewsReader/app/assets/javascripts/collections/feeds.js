NewsReader.Collections.Feeds = Backbone.Collection.extend({

  model: NewsReader.Models.Feed,
  url: "api/feeds",

  getOrFetch: function (id) {
    var feed = this.get(id);
    if (feed) {
      return feed;
    }
    var that = this;
    feed = new NewsReader.Models.Feed( {id: id} );
    feed.fetch({
      success: function (model) {
        that.add(model);
      }
    });

    return feed;
  }

});
