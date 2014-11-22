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

  def ==(other_card)
    self.suit == other_card.suit && self.value == other_card.value
  end

  def render
    "#{VALUES[value]}#{SUITS[suit]}"
  end

  def to_s
    render
  end

  def inspect
    render
  end

  def n_value
    VALUES.keys.reverse.index(self.value) + 2
  end

  def <=>(card)
    if self.n_value > card.n_value
      1
    elsif self.n_value == card.n_value
      0
    else
      -1
    end
  end

  def >(card)
    (self <=> card) == 1
  end

  def <(card)
    (self <=> card) == -1
  end
end
