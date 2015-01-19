window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var feeds = new NewsReader.Collections.Feeds();
    new NewsReader.Routers.Router({ feeds: feeds, $el: $("#content") });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
