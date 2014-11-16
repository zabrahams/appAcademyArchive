class Hangman

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

  def return_guess_indices
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
    secret_word.include?(guess)
  end

  def return_guess_indices(gues)
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
