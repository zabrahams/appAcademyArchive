var TTT = require("./../lib");
var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});


var game = new TTT.Game(reader);
game.play(function () {
  reader.close();
});
