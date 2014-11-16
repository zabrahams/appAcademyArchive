class Hangman

end

class HumanPlayer

  def pick_secret_word
  end

  def secret_length
  end

  def guess
  end

  def check_guess
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
