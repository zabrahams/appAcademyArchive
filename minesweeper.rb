require "./board"

class Minesweeper

  def initialize
    @board = Board.new
    @lost = false
  end

  def play
    until @lost
      @board.display
      input = get_input
      handle_input(input)
      if won?
        puts "You Won!!!!!!"
        break
      end
    end
  end

  def get_input
    puts "What is your move? (h for help, and q for quit)"
    print ">"

    input = gets.chomp
    coords = /[fru]\((\d*)\,(\d*)\)/.match(input)
    x, y = coords[1].to_i, coords[2].to_i unless coords.nil?
    system "clear"
    [input[0], x, y]
  end

  def handle_input(input)
    char, x, y = input
    case char
    when "f"
      @board[x,y].mark
    when "r"
      if lose?(x, y)
        puts "That was a bomb. You're the worst. We're all dead and it's your fault."
        @lost = true
      end
      reveal_neighbors(@board[x, y])
    when "h"
      help
    when "q"
      @lost = true
    when "u"
      @board[x,y].unmark
    end
  end


  def inspect
  end

  private

  def won?
    flagged = @board.count_flagged
    revealed = @board.count_revealed

    flagged == Board::NUM_BOMBS &&
      (flagged + revealed) == (Board::WIDTH * Boasrd::HEIGHT)
  end



  def help
    puts "F - flagged tile"
    puts "* - Unmarked tile"
    puts "r(coordinates) - reveals a tile"
    puts "f(coordinates) - flags a tile"
    puts "u(coordinates) - unmarks a tile"
  end

  def reveal_neighbors(tile) #tile method
    tile.reveal

    return if tile.neighbor_bomb_count > 0

    tile.neighbors.each do |neighbor|
      reveal_neighbors(neighbor) unless neighbor.flagged? || neighbor.revealed?
    end
  end

  def lose?(x, y)
    @board[x, y].bombed?
  end

end
