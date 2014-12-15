var Board = require("./board");

var Game = function (reader) {
    this.board = new Board();
    this.reader = reader;
    this.currentPlayer = "x";
}

Game.prototype.play = function (completionCallback) {
    var game = this;
    game.board.print();
    game.reader.question("Where would you like to move?\n", function(input) {
        try {
            Game.validateMove(input);
            var move = Game.convertMove(input);
            game.board.placeMark(move, game.currentPlayer);
            if (game.board.isWon()) {
                game.board.print();
                console.log(game.currentPlayer + " wins! Yay...");
                completionCallback();
            } else if (game.board.isFull() === true) {
                game.board.print();
                console.log("Nobody wins. Lame.");
                completionCallback();
            } else {
                game.flipCurrentPlayer();
                game.play(completionCallback);
            }
        }
        catch (e) {
          console.log(e);
          game.play(completionCallback);
        }
    });

}

Game.validateMove = function (pos) {
    var size = Board.SIZE - 1;
    var validDigits = "[0-" + size + "]";
    var reg = "^" + validDigits + "\\s+" + validDigits + "\\s*$";
    reg = new RegExp(reg);
    if (!reg.test(pos)) {
        throw new Error("Invalid move.");
    }
}

Game.convertMove = function (pos) {
    pos = pos.split(/\s+/);
    pos = pos.map(function (el) {
        return parseInt(el);
    });

    return pos;
}

Game.prototype.flipCurrentPlayer = function () {
    this.currentPlayer = (this.currentPlayer === 'x' ? 'o' : 'x');
}

module.exports = Game;
