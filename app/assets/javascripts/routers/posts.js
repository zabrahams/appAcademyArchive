Journyl.Routers.Posts = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el;
    this.posts = options.posts;
    this.$sidebar = this.$el.find('#index');
    this.$content = this.$el.find('#content');
  },
  routes: {
    "": "index",
    "posts/new": "new",
    "posts/:id": "show"
  },
  index: function () {
    var postsView = new Journyl.Views.PostsIndex({collection: this.posts});
    this._indexView = postsView;
    this.$sidebar.html(postsView.render().$el);
  },
  show: function (id) {
    var post = this.posts.getOrFetch(id);
    console.log(post.id);
    var postView = new Journyl.Views.PostShow({ model: post });
    this._swapView(postView);
    this._indexView || this.index();
  },
  new: function () {
    var post = new Journyl.Models.Post();
    var postForm = new Journyl.Views.PostForm({model: post, collection: this.posts});
    this._swapView(postForm);
    this._indexView || this.index();
  },
  _swapView: function (newView) {
    this._contentView && this._contentView.remove();
    this._contentView = newView;
    this.$content.html(newView.render().$el);
  }
});
