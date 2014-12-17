(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var _game = this.game;
    var _view = this;
    $("ul").on("click", "li",function(event){
      try {
        _game.playMove($(event.target).data("pos"));
        _view.makeMove($(event.target));
        if (_game.winner() !== null) {
          alert(_game.winner() + " has won!");
          $("ul").off("click");
        } else if (_game.isOver() === true) {
          alert ("The game is drawn!");
          $("ul").off("click");
        }
      } catch (e) {
        alert("That move is totally invalid!");
      }
    });
  };

  View.prototype.makeMove = function ($square) {
      if (this.game.currentPlayer === "x"){
        $square.addClass("red");
      } else {
        $square.addClass("blue");
      }
  };

  View.prototype.setupBoard = function () {
    var posArray = []
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        posArray.push([i, j]);
      }
    }

    this.$el.html("<ul class='group'></ul>");
    for (var i = 0; i < 9; i++) {
      var $li = $("<li></li>").data("pos", posArray[i]);
      $("ul").append($li);
    }

  };
})();
