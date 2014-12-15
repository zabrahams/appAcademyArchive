var readline = require("readline");
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var HanoiGame = function (size) {
    this.maxSize = (size === undefined ? 3 : size);
    this.stacks = HanoiGame.makeStacks(this.maxSize);
}

HanoiGame.makeStacks = function (size) {
    var stacks = [ [], [], [] ];
    for (var i = size; i > 0; i--) {
        stacks[0].push(i);
    }
    return stacks;
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
    var startStack = this.stacks[startIdx],
        endStack = this.stacks[endIdx];
    if (this.stacks[startIdx].length === 0) {
        throw new Error("Cannot move from empty stack. Yo!");
    } else if (this.stacks[endIdx].length === 0 ||
            startStack[startStack.length - 1] < endStack[endStack.length - 1]) {
        return true;
    }
    return false;
}

HanoiGame.prototype.move = function (startIdx, endIdx) {
    if (this.isValidMove(startIdx, endIdx) === true) {
        this.stacks[endIdx].push(this.stacks[startIdx].pop());
    } else {
        throw new Error("Not a valid move. Yo!");
    }
}

HanoiGame.prototype.promptMove = function (callback) {
    this.renderBoard();
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

HanoiGame.prototype.renderDisk = function (size) {
  var width = size * 2;
  var padding = ((this.maxSize * 2) - width) / 2;
  var disk = "";
  for (var i = 0; i < padding; i++) {
      disk += " ";
  }
  if (size !== 0) {
      disk += " ╔";
  } else {
      disk += "  ";
  }
  for (var i = 0; i < width; i++) {
      disk += "═";
  }
  if (size !== 0) {
      disk += "╗ ";
  } else {
      disk += "  ";
  }

  for (var i = 0; i < padding; i++) {
    disk += " ";
  }
  return disk;
}

HanoiGame.prototype.renderBoard = function () {
    process.stdout.write('\u001B[2J\u001B[0;0f'); //clears console
    var board = "";

    for (var i = this.maxSize; i >= 0; i--) {
        for (var j = 0; j < this.stacks.length; j++) {
            if (this.stacks[j][i] === undefined) {
              board += this.renderDisk(0);
            } else {
              board += this.renderDisk(this.stacks[j][i]);
            }
            if (j < this.stacks.length - 1) {
              board += " | ";
            }
        }
        board += "\n";
    }

    for (var i = 0; i < (this.maxSize * 6 + 18); i++) {
        board += "┉";
    }
    console.log(board);
}

var hanoi = new HanoiGame(40);
hanoi.run(function () {
    reader.close();
});

/* Todos:
1. Generalize size of stacks.
2. Catch validMove errors (make custom errors?)
3. Prettify printing of towers
4. Change the indexing of the towers in the user interface.
*/
