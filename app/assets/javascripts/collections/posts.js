Journyl.Collections.Posts = Backbone.Collection.extend({
  model: Journyl.Models.Post,
  url: '/posts',
  getOrFetch: function (id) {
    var posts = this;

    var post = this.get(id);
    if (typeof post === 'undefined') {
      post = new Journyl.Models.Post({id: id});
      post.fetch({
        success: function () {
          posts.add(post);
        }
      });
    } else {
      post.fetch();
    }
    return post;
  }
});
