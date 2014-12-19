$.UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find(".users");
  this.$el.on("input", this.handleInput.bind(this));
};

$.UserSearch.prototype.handleInput = function (event) {
  var that = this;

  $.ajax({
    type: "GET",
    url: "/users/search",
    dataType: "json",
    data: {query: this.$input.val()},
    success: function(resp) {
      console.log(resp);
      // var users = resp.map(function (user){
      //   return user.username;
      // });
      // console.log(users);
      that.renderResults(resp);
    }
  })
};

$.UserSearch.prototype.renderResults = function (users) {
  this.$ul.empty();
  var that = this;
  users.forEach (function (user) {
    var $li = $("<li>" + user.username + "</li>");
    var $button = $("<button class='followToggle'></button>");
    $button.followToggle({ userId: user.id, followState: user.followed.toString() });
    $li.append($button);
    that.$ul.append($li);
  });
};

$.fn.userSearch = function () {
  return this.each( function () {
    new $.UserSearch(this);
  })
}

$(function () {
  $(".user-search").userSearch();
})
