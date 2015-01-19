Array.prototype.bubbleSort = function () {
  var sorted = false;

  while (!sorted) {
    sorted = true;
    for (var i = 0; i < this.length - 1; i++) {
      if (this[i] > this[i+1]) {
        var temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        sorted = false;
      }
    };
  };
};

String.prototype.subStrings = function () {
  var substrings = [];

  for (var i = 0; i < this.length ; i++) {
    for (var j = i+1; j <= this.length; j++) {
      substrings.push(this.slice(i,j));
    };
  };

  return substrings;
};
