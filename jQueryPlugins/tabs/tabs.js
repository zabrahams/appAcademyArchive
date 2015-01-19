$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = this.$contentTabs.children(".active");
  this.$el.on("click", "a", this.clickTab.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  var $oldActiveTab = this.$activeTab;
  var $clickedTab = $(event.currentTarget);
  var that = this;

  $oldActiveTab.removeClass("active");
  $oldActiveTab.addClass("transitioning");

  $oldActiveTab.one("transitionend", function(event) {
    $oldActiveTab.removeClass("transitioning");
    $('a.active').removeClass("active");
    that.$activeTab = $($clickedTab.attr("href"));
    $clickedTab.addClass("active");
    that.$activeTab.addClass("transitioning active");
    window.setTimeout( function () {
      that.$activeTab.removeClass("transitioning");
    }, 0);

  });



};
