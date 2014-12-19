$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.maxCreatedAt = null;
  this.tweetTemplate = _.template(this.$el.find("script").html());

  this.$el.find("a.fetch-more").on("click", this.fetchTweets.bind(this));
};

$.InfiniteTweets.prototype.fetchTweets = function (event) {
  event.preventDefault();
  var ajaxOptions = {
    type: 'GET',
    url: '/feed',
    dataType: 'json',
    success: this.successfulFetch.bind(this)}

  if (this.maxCreatedAt != null) {
    ajaxOptions.data = {max_created_at: this.maxCreatedAt};
  }

  $.ajax(ajaxOptions);
};

$.InfiniteTweets.prototype.removeFetchTweets = function () {
  this.$el.find("a.fetch-more").remove();
  this.$el.append("All your tweets already belong to yous");
};

$.InfiniteTweets.prototype.successfulFetch = function (resp) {
  if (resp.length > 0) {
    this.$el.find("#feed").append(this.tweetTemplate({tweets: resp}));
      // ("<li>"+JSON.stringify(tweet)+"</li>");
    this.maxCreatedAt = resp[resp.length - 1].created_at;
  }
  if (resp.length < 20) {
    this.removeFetchTweets();
  }
}

$.fn.infiniteTweets = function () {
  return this.each ( function () {
    new $.InfiniteTweets(this);
  });
}

$(function () {
  $(".infinite-tweets").infiniteTweets();
});
