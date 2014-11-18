require "./board"
require "yaml"

class Minesweeper

  def initialize
    @board = Board.new
    @over = false
  end

  def play
    until @over
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
      @board[x,y].flag
    when "r"
      if lose?(x, y)
        puts "That was a bomb. You're the worst. We're all dead and it's your fault."
        @over = true
      end
      @board[x, y].reveal_neighbors
    when "h"
      help
    when "q"
      puts "Quiting"
      @over = true
    when "u"
      @board[x,y].unflag
    when "s"
      save_game
    when "c"
      load_game
    end
  end


  def inspect
  end

  private

  def won?
    flagged = @board.count_flagged
    revealed = @board.count_revealed

    flagged == Board::NUM_BOMBS &&
      (flagged + revealed) == (Board::WIDTH * Board::HEIGHT)
  end



  def help
    puts "F - flagged tile"
    puts "* - Unmarked tile"
    puts "r(coordinates) - reveals a tile"
    puts "f(coordinates) - flags a tile"
    puts "u(coordinates) - unmarks a tile"
    puts "q to quit"
    puts "s to save a game in progress"
    puts "c to continue a saved game"
  end



  def lose?(x, y)
    @board[x, y].bombed?
  end

  def save_game
    game_in_progress = @board.to_yaml
    File.write("saved_game.sav", game_in_progress)
    puts "Game saved.  Exiting."
    @over = true
  end

  def load_game
    game_in_progress = File.read("saved_game.sav")
    @board = YAML::load(game_in_progress)
    puts "Game loaded!"
  end

end
