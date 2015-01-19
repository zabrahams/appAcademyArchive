Array.prototype.myEach = function (fn) {
  for (var i = 0; i < this.length; i++) {
    fn(this[i]);
  };
  return this;
};

Array.prototype.myMap = function (fn) {
  var container = [];
  var map = function (x) {
    container.push(fn(x));
  };

  this.myEach(map);

  return container;
};

Array.prototype.myInject = function (fn) {
  var accumulator = this[0];

  var inject = function (el) {
    accumulator = fn(accumulator,el);
  };

  this.slice(1).myEach(inject);

  return accumulator;
};
