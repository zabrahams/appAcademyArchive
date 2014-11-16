class Hangman

end

class HumanPlayer

  def pick_secret_word
  end

  def receive_secret_length
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

  def receive_secret_length
  end

  def guess
  end

  def check_guess
  end

  def reveal_word
  end

  def handle_guess_response
  end

  private
  attr_writer :secret_word

  def load_dictionary
    File.readlines(DICT_FILE).map(&:chomp)
  end

end
