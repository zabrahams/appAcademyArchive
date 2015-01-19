NewsReader.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.expandedArticles = {};
  },

  events: {
    "click li a.headline": "toggleEntry",
    "click button.refresh": "refreshFeed"
  },

  render: function () {
    this.$el.html(this.template( { feed: this.model, entries: this.model.entries() } ));
    return this;
  },

  refreshFeed: function () {
    this.model.fetch({success: this.render.bind(this)});
  },

  toggleEntry: function(event) {
    var $li = $(event.currentTarget).parent();
    var entryId = $li.data('id');
    var article = this.expandedArticles[entryId];
    if (article) {
      article.remove();
      delete this.expandedArticles[entryId];
    } else {
      var entry = this.model.entries().get(entryId);
      var showView = new NewsReader.Views.EntryShow({model: entry});
      this.expandedArticles[entryId] = showView;
      $li.append(showView.render().$el);
    }
  },

  leave: function () {
    _.each(this.expandedArticles, function (view) {
      view.leave();
    })
    this.remove();
  }
})
