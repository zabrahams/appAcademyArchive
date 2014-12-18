$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = $(".gutter-images img").first();
  this.activate(this.$activeImg);
  this.gutterIdx = 0;
  this.$images = $(".gutter-images").children();
  this.fillGutterImages();
  this.addClickHandlers();
}

$.Thumbnails.prototype.addClickHandlers = function() {
  $(".gutter-images").on("click", "img", this.onClick.bind(this));
  $(".gutter-images").on("mouseenter", "img", this.onMouseEnter.bind(this));
  $(".gutter-images").on("mouseleave", "img", this.onMouseLeave.bind(this));
  $(".nav-left").on("click", this.onSwitch.bind(this, -5));
  $(".nav-right").on("click", this.onSwitch.bind(this, 5));

};

$.Thumbnails.prototype.activate = function ($img) {
  var $newImg = $img.clone();
  $(".active").html($newImg);

}

$.fn.thumbnails = function () {
  return this.each( function () {
    new $.Thumbnails(this);
  });
};

$.Thumbnails.prototype.onClick = function(event) {
  this.$activeImg = $(event.currentTarget);
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.onMouseEnter = function(event) {
  this.activate($(event.currentTarget));
};

$.Thumbnails.prototype.onMouseLeave = function(event) {
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.onSwitch = function(dir) {
  var newIdx = dir + this.gutterIdx
  console.log(newIdx)
  if (newIdx >= 0 && newIdx < this.$images.length) {
    this.gutterIdx = newIdx
    var $gutter = $(".gutter-images");
    $gutter.empty();
    for (var i = 0; i < 5; i++) {
      $gutter.append(this.$images.eq(this.gutterIdx + i));
    }
  }
};

$.Thumbnails.prototype.fillGutterImages = function() {
  var $gutter = $(".gutter-images");
  $gutter.empty();
  for (var i = 0; i < 5; i++) {
    $gutter.append(this.$images.eq(this.gutterIdx + i));
  }
}
