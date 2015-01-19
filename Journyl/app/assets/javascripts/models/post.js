Journyl.Models.Post = Backbone.Model.extend({
  urlRoot: '/posts',
  validate: function (attrs, options) {
    if (attrs.post) {
      if (attrs.post.title === "" || typeof attrs.post.title === "undefined") {
        return "Danger! Danger! Title cannot be blank.";
      }
      if (attrs.post.body === "" || typeof attrs.post.body === "undefined") {
        return "Danger! Danger! Body cannot be empty.";
      }
    } else {
      if (attrs.title === "" || typeof attrs.title === "undefined") {
        return "Danger! Danger! Title cannot be blank.";
      }
      if (attrs.body === "" || typeof attrs.body === "undefined") {
        return "Danger! Danger! Body cannot be empty.";
      }
    }
  }
});
