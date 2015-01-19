Journyl.Views.PostsIndex = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "remove change:title reset add", this.render);
  },
  events: {
    'click button.delete-btn': 'deletePost'
  },
  template: JST['posts/index'],
  render: function () {
    this.$el.html(this.template({ posts: this.collection }));
    return this;
  },
  deletePost: function (event) {
    var button = $(event.currentTarget);
    var id = button.data('id');
    this.collection.get(id).destroy();
  }
});
