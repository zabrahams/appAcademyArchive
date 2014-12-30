NewsReader.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.refresh": "refreshFeed"
  },

  render: function () {
    this.$el.html(this.template( { feed: this.model, entries: this.model.entries() } ));
    return this;
  },

  refreshFeed: function () {
    this.model.fetch({success: this.render.bind(this)});
  }
})
