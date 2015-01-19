NewsReader.Views.FeedsIndex = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  events: {
    "click button.feed-delete": "deleteFeed"
  },

  template: JST['feeds/index'],

  render: function () {
    this.$el.html(this.template( { feeds: this.collection } ));
    return this;
  },

  leave: function () {
    this.remove();
  },

  deleteFeed: function (event) {
    var $button = $(event.currentTarget);
    var feedId = $button.data("id");
    console.log($button);
    var feed = this.collection.get(feedId);
    feed.destroy({success: this.render.bind(this)});
    // this.collection.fetch();
  }

});
