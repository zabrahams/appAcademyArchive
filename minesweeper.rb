require "./board"

class Minesweeper

  def initialize
    @board = Board.new
    @board.make_board
  end

  def play
    while true
      @board.display
      puts "What is your move? (h for help, and q for quit)"
      print ">"

      input = gets.chomp
      coords = /[fru]\((\d*)\,(\d*)\)/.match(input)
      x, y = coords[1].to_i, coords[2].to_i unless coords.nil?
      system "clear"

      case input[0]
      when "f"
        @board[x,y].mark
      when "r"
        if lose?(x, y)
          puts "That was a bomb. You're the worst. We're all dead and it's your fault."
          break
        end
        reveal_neighbors(@board[x, y])
      when "h"
        help
      when "q"
        break
      when "u"
        @board[x,y].unmark
      end

      if won?
        puts "You Won!!!!!!"
        break
      end
    end
  end

  def inspect
  end

  private

  def won?
    flag_and_reveal = count_flagged_and_revealed
    flagged = flag_and_reveal[:flagged]
    revealed = flag_and_reveal[:revealed]

    flagged == Board::NUM_BOMBS &&
      (flagged + revealed) == (Board::WIDTH*Board::HEIGHT)
  end

  def count_flagged_and_revealed
    flag_and_reveal = {:flagged => 0, :revealed => 0}
    Board::HEIGHT.times do |y|
      Board::WIDTH.times do |x|
        if @board[x, y].marked
          flag_and_reveal[:flagged] += 1
        elsif @board[x, y].revealed
          flag_and_reveal[:revealed] += 1
        end
      end
    end

    flag_and_reveal
  end

  def help
    puts "F - flagged tile"
    puts "* - Unmarked tile"
    puts "r(coordinates) - reveals a tile"
    puts "f(coordinates) - flags a tile"
    puts "u(coordinates) - unmarks a tile"
  end

  def reveal_neighbors(tile)
    tile.reveal

    return if tile.neighbor_bomb_count > 0

    tile.neighbors.each do |neighbor|
      reveal_neighbors(neighbor) unless neighbor.marked || neighbor.revealed
    end
  end

  def lose?(x, y)
    @board[x, y].bombed
  end

end
