$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = $(".gutter-images img").first();
  console.log(this.$activeImg);
  this.activate(this.$activeImg);
  this.gutterIdx = 0;
  this.$images = $(".gutter-images").children();
  this.fillGutterImages();


  $(".gutter-images").on("click", "img", this.onClick.bind(this));
  $(".gutter-images").on("mouseenter", "img", this.onMouseEnter.bind(this));
  $(".gutter-images").on("mouseleave", "img", this.onMouseLeave.bind(this));
}

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

$.Thumbnails.prototype.fillGutterImages = function() {
  var $gutter = $(".gutter-images");
  $gutter.empty();
  for (var i = 0; i < 5; i++) {
    $gutter.append(this.$images.eq(this.gutterIdx + i));
  }
}
