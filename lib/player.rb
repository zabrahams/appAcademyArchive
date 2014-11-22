class InvalidInputError < StandardError
end

require "colorize"

class Player

  attr_accessor :hand, :pot

  def initialize(pot)
    @hand = nil
    @pot = pot
  end

  def get_discard
    puts "Please write the indices of the cards you would"
    puts "like to discard, seperated by commas."
    begin
      print ">".blink
      indices = gets.chomp
      unless indices =~ /\A([0-4]\s*\,\s*)*([0-4])?\z/
        raise InvalidInputError.new "You input an illegal character."
      end
      indices = indices.split(",").map(&:to_i)
      validate_indices(indices)
    rescue InvalidInputError => e
      puts e.message
      puts "Please attempt your input again."
      retry
    end

    return indices
  end

  def bet_response(bet)

  end

  def validate_indices(indices)
    unless indices.uniq == indices
      raise InvalidInputError.new "You can only a card once."
    end

    if indices.count > 2
      raise InvalidInputError.new "You are attempting to discard too many cards"
    end
  end

  def fold
    hand = nil
  end

  def see(bet)
    raise BettingError.new "Not enough money!" if bet > pot
    self.pot -= bet
    bet
  end

  def raise(bet, raise)
    raise BettingError.new "Not enough money!" if bet + rasie > pot
    if new_bet <= bet
    self.pot -= bet + raise
    bet + raise
  end

end
