$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$inputs = this.$el.find(":input");
  this.$textarea = this.$el.find("textarea");

  this.$el.on("submit", this.submit.bind(this));
  this.$textarea.on("input", this.updateCounter.bind(this));
  this.$el.find(".add-mentioned-user").on("click", this.addMentionedUser.bind(this));
  this.$el.find(".mentioned-users").on("click", "a", this.removeMentionedUser.bind(this));
};

$.fn.tweetCompose = function () {
  return this.each(function() {
    new $.TweetCompose(this);
  });
};

$.TweetCompose.prototype.addMentionedUser = function (event) {
  var $script = this.$el.find("script");
  var scriptHTML = $script.html();
  this.$el.find("div.mentioned-users").append(scriptHTML);
};

$.TweetCompose.prototype.removeMentionedUser = function (event) {
  $(event.currentTarget).parent().remove();
};

$.TweetCompose.prototype.updateCounter = function (event) {
   var numChars = this.$textarea.val().length;
   var charsLeft = 140 - numChars < 0 ? 0 : 140 - numChars;
   this.$el.find(".chars-left").html( charsLeft.toString() + " characters remaining");
};

$.TweetCompose.prototype.submit = function (event){
  event.preventDefault();
  var formData = this.$el.serialize();
  this.$inputs.prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: formData,
    dataType: "json",
    success: this.handleSuccess.bind(this)
  });
}

$.TweetCompose.prototype.clearInput = function () {
  this.$textarea.val("");
  this.$el.find("div.mentioned-users").empty();
};

$.TweetCompose.prototype.handleSuccess = function (resp) {
  this.clearInput();
  this.updateCounter();
  this.$inputs.prop("disabled", false);
  // $(this.$el.attr("data-tweets-ul")).prepend("<li>" + JSON.stringify(resp) + "</li>");
  $(document).trigger("insert-tweet", resp);
};

$(function () {
  $(".tweet-compose").tweetCompose();
});
