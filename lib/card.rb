class InvalidSuitError < StandardError
end

class InvalidCardValueError < StandardError
end

class Card

  SUITS = {
    :spades => "♠",
    :hearts => "♥",
    :diamonds => "♦",
    :clubs => "♣"
  }

  VALUES = {
    :ace => "A",
    :king => "K",
    :queen => "Q",
    :jack => "J",
    :ten => "10",
    :nine => "9",
    :eight => "8",
    :seven => "7",
    :six => "6",
    :five => "5",
    :four => "4",
    :three => "3",
    :deuce => "2"
  }

  attr_reader :suit, :value

  def initialize(suit, value)
    raise InvalidSuitError.new "Cannot initialize card with that suit." unless SUITS.keys.include?(suit)
    raise InvalidCardValueError.new "Cannot initialize card with that value." unless VALUES.keys.include?(value)
    @suit = suit
    @value = value
  end

end
