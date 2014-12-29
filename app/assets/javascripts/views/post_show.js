Journyl.Views.PostShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model, "invalid", this.render);
  },
  events: {
    'dblclick .title': 'editTitle',
    'dblclick .body': 'editBody',
    'blur .body_input': 'saveBody',
    'blur .title_input': 'saveTitle'
  },
  template: JST['posts/show'],
  render: function () {
    this.$el.html(this.template({post: this.model}));
    this.model.validationErrors = undefined;
    return this;
  },
  editTitle: function(event) {
    var $title = $(event.currentTarget);
    $title.html(JST['posts/editTitle']({ post: this.model }));
  },
  editBody: function(event) {
    var $body = $(event.currentTarget);
    $body.html(JST['posts/editBody']({ post: this.model }));
  },
  saveTitle: function(event) {
    var $title = $(event.currentTarget);
    var content = $title.val();
    this.model.save({title: content}, {
      success: function () {
        this.render();
      }.bind(this)
    });
  },
  saveBody: function(event) {
    var $body = $(event.currentTarget);
    var content = $body.val();
    this.model.save({body: content}, {
      success: function () {
        this.render();
      }.bind(this)
    });
  }
});
