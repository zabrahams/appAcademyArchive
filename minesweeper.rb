require "./board"

class Minesweeper

  def initialize
    @board = Board.new
    @board.make_board
  end

  def play
    @board.display
    puts "What is your move? (h for help)"
    print ">"

    begin
      input = gets.chomp

      case input[0]
      when "f"
      when "r"
      when "h"
        help
      else
        raise "Invalid input"
      end
    rescue
      puts "Invalid input!"
      print ">"
      retry
    end
  end

  def inspect
  end

  private

  def won?
  end

  def help
    puts "F - flagged tile"
    puts "* - Unmarked tile"
    puts "r(coordinates) - reveals a tile"
    puts "f(coordinates) - flags a tile"
  end

end
