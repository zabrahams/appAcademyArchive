var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var HanoiGame = function () {
    this.stacks = [[1,2,3],[],[]];
}

HanoiGame.prototype.isWon = function () {
    if (this.stacks[0].length === 0 &&
        this.stacks[1].length === 0) {
        return true;
    } else {
        return false;
    }
}

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
    if (this.stacks[startIdx].length === 0) {
        throw new Error("Cannot move from empty stack. Yo!");
    } else if (this.stacks[endIdx].length === 0 ||
            this.stacks[startIdx][0] < this.stacks[endIdx][0]) {
        return true;
    }
    return false;
}

HanoiGame.prototype.move = function (startIdx, endIdx) {
    if (this.isValidMove(startIdx, endIdx) === true) {
        this.stacks[endIdx].unshift(this.stacks[startIdx].shift());
    } else {
        throw new Error("Not a valid move. Yo!");
    }
}

HanoiGame.prototype.print = function () {
    console.log(JSON.stringify(this.stacks));
}

HanoiGame.prototype.promptMove = function (callback) {
    this.print();
    reader.question("Which stack would you like to move from? ", function (startStr) {
      reader.question("Which stack would you like to move to? ", function (endStr) {
          var start = parseInt(startStr);
          var end = parseInt(endStr);
          callback(start, end);
      });
    });
}

HanoiGame.prototype.run = function (completionCallback) {
    var game = this;
    
    game.promptMove(function (start, end) {
        try {
            game.move(start, end);
        } catch (e){
            console.log(e);
        }

        if (game.isWon() === false) {
            game.run(completionCallback);
        } else {
            console.log("You won! Yo.");
            completionCallback();
        }
    });

}

var hanoi = new HanoiGame();
hanoi.run(function () {
    reader.close();
});

/* Todos:
1. Generalize size of stacks.
2. Catch validMove errors (make custom errors?)
3. Prettify printing of towers
4. Change the indexing of the towers in the user interface.
*/
