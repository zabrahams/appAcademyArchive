class Hangman

  attr_accessor :board, :master, :guesser, :current_turn
  MAX_TURNS = 10

  def initialize(master, guesser)
    @master = master
    @guesser = guesser
  end

  def run
    master.pick_secret_word
    @board = Array.new(master.secret_length)
    @current_turn = 0

    until (won? || current_turn == MAX_TURNS)
      play_turn
    end

    if won?
      puts "You did it! You guessed '#{render_board}'"
    else
     puts "You couldn't even get an easy word like '#{master.reveal_word}'. Shame on you."
   end
  end

  def play_turn
    puts "#{render_board}    Turn: #{current_turn + 1}"
    guess = guesser.guess
    update_board(guess, master.check_guess(guess))
    self.current_turn += 1
  end

  def won?
    board.none?(&:nil?)
  end

  def update_board(guess, indices)
    indices.each { |i| board[i] = guess }
  end

  def render_board
    board.map { |letter| letter.nil? ? "_" : letter }.join("")
  end

end

class HumanPlayer

  def pick_secret_word
  end

  def secret_length
  end

  def guess
    puts "Please make a guess!"
    begin
      guess = gets.chomp.downcase

      raise "Error - Input Too long!" unless guess.length == 1
      raise "Error - Input Not a Letter" unless ("a".."z").include?(guess)

      guess

    rescue Exception => err
      puts err.message
      puts "Please try your input again."
      retry
    end
  end

  def check_guess
  end

  def guess_indices
  end

  def handle_guess_response
  end

end

class ComputerPlayer
  DICT_FILE = "dictionary.txt"

  def pick_secret_word
    dictionary = load_dictionary
    @secret_word = dictionary.sample
  end

  def secret_length
    secret_word.length
  end

  def guess
  end

  def check_guess(guess)
    (0...secret_word.length).select { |i| secret_word[i] == guess }
  end

  def reveal_word
    secret_word
  end

  def handle_guess_response(guess)

  end

  private
  attr_reader :secret_word

  def load_dictionary
    File.readlines(DICT_FILE).map(&:chomp)
  end

end

if __FILE__ == $PROGRAM_NAME
  hum = HumanPlayer.new
  comp = ComputerPlayer.new
  game = Hangman.new(comp, hum)
  game.run
end
