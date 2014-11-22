require_relative "card"

class Deck

  def self.setup_deck
    cards = []
    Card::SUITS.keys.each do |suit|
      Card::VALUES.keys.each do |value|
        cards << Card.new(suit, value)
      end
    end

    Deck.new(cards)
  end

  attr_accessor :cards

  def initialize(cards = Deck.setup_deck.cards)
    @cards = cards
  end

  def shuffle
    cards.shuffle!
    self
  end

  def draw(n)
    cards.shift(n)
  end

  def deal_hand
    draw(5)
  end

end
