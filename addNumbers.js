var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});


var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function (num) {
      var input = parseInt(num);
      sum += input;
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
