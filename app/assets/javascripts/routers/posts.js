Journyl.Routers.Posts = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el;
    this.posts = options.posts;
  },
  routes: {
    "": "index",
    "posts/new": "new",
    "posts/:id": "show"
  },
  index: function () {
    var postsView = new Journyl.Views.PostsIndex({collection: this.posts});
    this.$el.html(postsView.render().$el);
  },
  show: function (id) {
    var post = this.posts.getOrFetch(id);
    var postView = new Journyl.Views.PostShow({model: post});
    this.$el.html(postView.render().$el);
  },
  new: function () {
    var post = new Journyl.Models.Post();
    var postForm = new Journyl.Views.PostForm({model: post, collection: this.posts});
    this.$el.html(postForm.render().$el);
  }
});
