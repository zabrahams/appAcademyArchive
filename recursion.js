var range = function (start,end) {
  if (end < start) {
    return [];
  }
  else if (end === start) {
    return [start];
  }
  else {
    var prev_range = range(start, end - 1);
    prev_range.push(end);

    return prev_range;
  }
};

Array.prototype.rSum = function () {
  if (this.length === 0) {
    return 0;
  }
  else if (this.length === 1) {
    return this[0];
  }
  else {
    var last = this.slice(0, this.length - 1).rSum();
    return last + this[(this.length - 1)];
  }
};

var exponent = function (base, exp) {
  if (exp === 0) {
    return 1;
  }
  else if (exp === 1) {
    return base;
  }
  else {
    var last = exponent(base, Math.floor(exp / 2));
    var squared = last * last;
    if ( exp % 2 === 0) {
      return squared;
    }
    else {
      return squared * base;
    }
  }
};

var fibs = function (num) {
  if (num === 0) {
    return [];
  }
  else if (num === 1) {
    return [0];
  }
  else if (num === 2) {
    return [0,1];
  }
  else {
    var last_fib = fibs(num - 1);
    last_fib.push(last_fib[last_fib.length -1] + last_fib[last_fib.length -2]);
    return last_fib;
  }
};

var bSearch = function(array, target) {
  if (array.length === 0) {
    return null;
  }
  else if (array.length === 1) {
    if (array[0] === target) {
      return 0;
    }
    else {
      return null;
    }
  }
  else {
    var mid_index = Math.floor(array.length/2);
    if (array[mid_index] === target) {
      return mid_index;
    }
    else {
      var left = bSearch(array.slice(0, mid_index), target);
      if (left != null) {
        return left;
      }
      var right = bSearch(array.slice(mid_index, array.length), target);
      if (right != null) {
        return right + mid_index;
      }
    }
  }
};

Array.prototype.includes = function(value) {
  for (var i=0; i < this.length; i++) {
    if (this[i] === value) {
      return true;
    }
  }

  return false;
}



var makeChange = function(number, coins) {
  if (coins.length === 0 && number) {
    return null;
  }
  else if (coins.includes(number) ){
    return [number];
  }
  else {
    var best_coins = null;
    var min_size = Number.POSITIVE_INFINITY;
    for ( var i = 0; i < coins.length; i++) {
      var coin = coins[i];
      if (coin > number) {
        return makeChange(number, coins.slice(1,coins.length));
      }
      else {
        var prev_coins = makeChange(number - coin, coins);
        if (prev_coins) {
          prev_coins.unshift(coin);
          if (prev_coins.length < min_size) {
            min_size = prev_coins.length;
            best_coins = prev_coins;
          }
        }
      }
    };

    return best_coins;
  }
};
