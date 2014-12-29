window.Journyl = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');
  }
};

$(document).ready(function(){
  Journyl.initialize();
  var posts = new Journyl.Collections.Posts;
  posts.fetch({
    success: function () {
      var postsView = new Journyl.Views.PostsIndex({ el: "body", collection: posts });
      postsView.render();
    }
  });
});
