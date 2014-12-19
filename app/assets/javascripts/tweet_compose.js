$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$inputs = this.$el.find(":input");
  this.$textarea = this.$el.find("textarea");

  this.$el.on("submit", this.submit.bind(this));
  this.$textarea.on("input", this.updateCounter.bind(this));
};

$.fn.tweetCompose = function () {
  return this.each(function() {
    new $.TweetCompose(this);
  });
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
  var that = this;

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: formData,
    dataType: "json",
    success: that.handleSuccess.bind(that)
  });
}

$.TweetCompose.prototype.clearInput = function () {
  this.$textarea.val("");
};

$.TweetCompose.prototype.handleSuccess = function (resp) {
  this.clearInput();
  this.updateCounter();
  this.$inputs.prop("disabled", false);
  $(this.$el.attr("data-tweets-ul")).prepend("<li>" + JSON.stringify(resp) + "</li>");
};

$(function () {
  $(".tweet-compose").tweetCompose();
});
