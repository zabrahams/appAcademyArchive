Array.prototype.includes = function(value) {
  for (var i=0; i < this.length; i++) {
    if (this[i] === value) {
      return true;
    }
  }

  return false;
}



Array.prototype.myUniq = function() {
  var container = [];
  for (var i=0; i < this.length; i++) {
    if (!(container.includes(this[i]))) {
      container.push(this[i]);
    }
  };
  return container;
};

Array.prototype.twoSum = function() {
  var container = [];
  for (var i=0; i < this.length - 1; i++) {
    for (var j=i+1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        container.push([i,j]);
      }
    };
  };

  return container;
};

Array.prototype.transpose = function() {
  var container = new Array(this.length) ;
  for (var i=0; i < container.length; i++) {
    container[i] = new Array(this.length);
  };

  for (var i=0; i < this.length; i++) {
    for (var j=0; j < this.length; j++) {
      container[j][i] = this[i][j];
    };
  };
  return container;
};
