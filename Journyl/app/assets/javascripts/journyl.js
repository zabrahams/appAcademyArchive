window.Journyl = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
  }
};

$(document).ready(function(){
  Journyl.initialize();
  var posts = new Journyl.Collections.Posts;
  posts.fetch();
  new Journyl.Routers.Posts({ $el: $("body"), posts: posts });
  Backbone.history.start();
});
