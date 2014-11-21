require_relative "deck"

class Hand

  attr_accessor :cards

  def initialize(deck)
    @cards = deck.draw(5)
  end

  def draw(deck, n)
    self.cards += deck.draw(n)
  end

  def discard(indices)
    self.cards = cards.reject { |card| indices.include?(cards.index(card)) }
  end
end
