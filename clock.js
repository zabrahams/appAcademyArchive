function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var time = this.currentTime;
  console.log(time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  var time = this.currentTime;
  time.setMilliseconds(time.getMilliseconds() + Clock.TICK);
  this.printTime();
};

var clock = new Clock();
clock.run();
