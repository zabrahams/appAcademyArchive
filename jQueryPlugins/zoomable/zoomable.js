$.Zoomable = function (el) {
  this.$el = $(el);
  this.focusBoxSize = 50;
  // this.focusBoxDisplay = false;

  this.$el.on("mousemove",  this.showFocusBox.bind(this));
  // this.$el.on("mouseout",  this.removeFocusBox.bind(this));
};

$.fn.zoomable = function () {
  return this.each( function () {
    new $.Zoomable(this);
  });
};

$.Zoomable.prototype.showFocusBox = function (event) {
  if (typeof this.$focusBox !== "undefined") {
    this.$focusBox.remove();
    $("div.zoomed-image").remove();
  }

  var xDiff = event.screenX - this.focusBoxSize/2;
  var yDiff = event.screenY - this.focusBoxSize*2.5;
  this.$focusBox = $("<div class='focus-box'></div>");
  this.$focusBox.css({ height: this.focusBoxSize,
                       width: this.focusBoxSize,
                       top: yDiff,
                       left: xDiff});
  this.$el.append(this.$focusBox);
  this.showZoom(xDiff, yDiff);
};

$.Zoomable.prototype.showZoom = function (xDiff, yDiff) {
  var $zoom = $("<div></div>").addClass("zoomed-image");
  var winHeight = $(window).height();
  $("body").append($zoom);
  console.log("X " + xDiff);
  console.log("Y " +  yDiff);
  $zoom.css({ width: winHeight,
              "background-image": 'url("../assets/images/Bruegel.jpg")',
              "background-size": "600% 600%",
              "background-position": "" + (xDiff/250)*100 + "% " + (yDiff/165)*100 + "%"});

};
