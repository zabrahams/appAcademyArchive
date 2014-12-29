Journyl.Views.PostForm = Backbone.View.extend({
  events: {
    'submit #post_form': 'handleFormSubmission'
  },
  template: JST['posts/form'],
  render: function () {
    this.$el.html(this.template({post: this.model}));
    return this;
  },
  handleFormSubmission: function(event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON();
    this.model.save(attrs, {
      success: function () {
        this.collection.add(this.model, {merge: true});
        Backbone.history.navigate("", {trigger: true});
      }.bind(this),
      error: function () {
        this.render();
      }.bind(this)
    });
  }
});
