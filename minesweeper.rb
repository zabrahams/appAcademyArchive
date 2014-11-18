require "./board"
require "yaml"

class Minesweeper

  def initialize
    @board = Board.new
    @over = false
  end

  def play
    until @over
      system "clear"
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
    puts "* - Unflaged tile"
    puts "r(coordinates) - reveals a tile"
    puts "f(coordinates) - flags a tile"
    puts "u(coordinates) - unflags a tile"
    puts "q to quit"
    puts "s to save a game in progress"
    puts "c to continue a saved game"
    gets
  end



  def lose?(x, y)
    @board[x, y].bombed?
  end

  def save_game
    puts "Please input a filename:"
    filename = gets.chomp
    game_in_progress = @board.to_yaml
    File.write("#{filename}.sav", game_in_progress)
    puts "Game saved.  Exiting."
    @over = true
  end

  def load_game
    puts "Current saved games are:"
    save_files = Dir.glob("*.sav")
    puts save_files

    puts "Which would you like to load?"
    begin
      file_name = gets.chomp
      raise "File not found!" if (!save_files.include?(file_name)) && (file_name != "")
    rescue
      puts "File not found! Leave a blank line to cancel loading."
      retry
    end

    unless file_name == ""
      game_in_progress = File.read("saved_game.sav")
      @board = YAML::load(game_in_progress)
      puts "Game loaded!"
    end
  end

end

if $PROGRAM_NAME == __FILE__
  mine = Minesweeper.new
  mine.play
end
