var Board = function () {
  this.grid = Board.makeGrid();
}

Board.SIZE = 3;

Board.makeGrid = function () {
    var grid = new Array(Board.SIZE);
    for (var i = 0; i < grid.length; i++) {
        grid[i] = new Array(Board.SIZE);
    }

    return grid;
}

Board.prototype.isEmpty = function (pos) {
    return (this.grid[pos[0]][pos[1]] === undefined);
}

Board.prototype.placeMark = function (pos, mark) {
    if (this.isEmpty(pos)) {
        this.grid[pos[0]][pos[1]] = mark;
    } else {
        throw new Error("There is already a mark there.");
    }
}

Board.prototype.isFull = function () {
    for (var i = 0; i < Board.SIZE; i++) {
        for (var j = 0; j < Board.SIZE; j++) {
            if (this.grid[i][j] === undefined) {
                return false;
            }
        }
    }
    return true;
}

Board.prototype.isWon = function () {
    return this.isWonHor() || this.isWonVer() || this.isWonDiag();
}

Board.prototype.isWonHor = function () {
    for (var i = 0; i < Board.SIZE; i++) {
        var count = 1;
        var mark = this.grid[i][0];
        if (mark !== undefined) {
            for (var j = 1; j < Board.SIZE; j++) {
                if (this.grid[i][j] === mark) {
                    count += 1;
                }
            }
        }
        if (count === Board.SIZE) {
            return true;
        }
    }

    return false;
}

Board.prototype.isWonVer = function () {
    for (var i = 0; i < Board.SIZE; i++) {
        var count = 1;
        var mark = this.grid[0][i];
        if (mark !== undefined) {
            for (var j = 1; j < Board.SIZE; j++) {
                if (this.grid[j][i] === mark) {
                    count += 1;
                }
            }
        }
        if (count === Board.SIZE) {
            return true;
        }
    }

    return false;
}

Board.prototype.isWonDiag = function () {
    var count = 1;
    var mark = this.grid[0][0];
    if (mark !== undefined) {
        for (var i = 1; i < Board.SIZE; i++) {
            if (this.grid[i][i] === mark) {
                count += 1;
            }
        }
    }

    if (count === Board.SIZE) {
        return true;
    }

    count = 1;
    mark = this.grid[Board.SIZE - 1][Board.SIZE - 1];
    if (mark !== undefined) {
        for (var i = Board.SIZE-2; i >= 0; i--) {
            if (this.grid[i][i] === mark) {
                count += 1;
            }
        }
    }

    if (count === Board.SIZE) {
      return true;
    }
}

Board.prototype.print = function() {
    process.stdout.write('\u001B[2J\u001B[0;0f'); //clears console
    console.log("    0   1   2  ");
    console.log("  ╔═══╦═══╦═══╗")
    for (var i = 0; i < Board.SIZE; i++) {
        var row = [];
        for (var j = 0; j < Board.SIZE; j++) {
            var el = this.grid[i][j];
            row.push(el === undefined ? " " : el);
        }
        console.log(i + " ║ " + row.join(" ║ ") + " ║");
        if (i < (Board.SIZE - 1)) {
            console.log("  ╠═══╬═══╬═══╣");
        } else {
            console.log("  ╚═══╩═══╩═══╝");
        }
    }
}

module.exports = Board;



//
// var empty = function() {
//   var x = arguments[0]
//   var y = arguments[1]
//   empty([x, y]);
// }

/* TODO
1. Custom errors?
2. Modular board size
3. Make win conditions not suck
*/
