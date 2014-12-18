$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.addClickHandlers();
  this.transitioning = false;
}

$.Carousel.prototype.slide = function(dir) {
  if (this.transitioning === false) {
    console.log("transitioning")
    var that = this;
    var newIdx = this.activeIdx + dir;
    var slides = this.$el.children();
    var dirClass = (dir === 1 ? "right" : "left");
    var otherDir = (dirClass === "right" ? "left" : "right");
    var $oldSlide = slides.eq(that.activeIdx);
    if (newIdx >= 0 && newIdx < slides.length) {
      this.transitioning = true;


      slides.eq(newIdx).addClass('active ' + dirClass);

      window.setTimeout(function() {
        console.log("setTimeout")
        slides.eq(newIdx).removeClass(dirClass);
        $oldSlide.addClass(otherDir);
        that.activeIdx = newIdx;
      }, 0);

      $oldSlide.one("transitionend", function (even) {
        console.log("transitionend")
        $(event.currentTarget).removeClass("active left right");
        that.transitioning = false;
      });
    }
  }
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};


$.Carousel.prototype.addClickHandlers = function() {
  var that = this;

  $(".slide-left").on("click", that.slide.bind(that, 1));
  $(".slide-right").on("click", that.slide.bind(that, -1));

};
