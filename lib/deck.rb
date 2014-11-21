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

  def initialize(cards)
    @cards = cards
  end

  

end
