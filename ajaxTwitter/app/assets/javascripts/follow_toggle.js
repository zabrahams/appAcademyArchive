  $.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.attr("data-user-id") || options.userId;
  this.followState = this.$el.attr("data-user-initial-follow-state") || options.followState;
  this.$el.on("click", this.handleClick.bind(this));
  this.render();
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
    this.$el.text(this.followState);
  } else if (this.followState === "true") {
    this.$el.text("Unfollow!");
  } else {
    this.$el.text("Follow!");
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  var that = this;
  event.preventDefault();


  if (this.followState === "false") {
    this.followState = "following";
    this.render();
    $.ajax({
      type: "POST",
      url: "/users/" + this.userId + "/follow",
      dataType: 'json',
      success: function () {
        that.followState = "true";
        that.$el.prop("disabled", false);
        that.render();
      }
    });
  } else {
    this.followState = "unfollowing";
    this.render();
    $.ajax({
      type: "DELETE",
      url: "/users/" + this.userId + "/follow",
      dataType: 'json',
      success: function () {
        that.followState = "false";
        that.$el.prop("disabled", false);
        that.render();
      }
    });
  }
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
