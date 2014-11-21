require_relative "deck"

class Hand

  HEIRARCHY = [
    
  ]

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

  def pair?
    value_count.values.include?(2)
  end

  def triplet?
    value_count.values.include?(3)
  end

  def quad?
    value_count.values.include?(4)
  end

  def full_house?
    pair? && triplet?
  end

  def flush?
    suit_count.values.include?(5)
  end

  def straight?
    values = cards.map { |card| card.value }
    value_indices = values.map { |value| Card::VALUES.keys.index(value) }
    smallest = value_indices.min
    (smallest..smallest + 4).to_a == value_indices.sort
  end

  def straight_flush?
    straight? && flush?
  end

  private
  def value_count
    res = Hash.new(0)
    cards.each { |card| res[card.value] += 1 }
    res
  end

  def suit_count
    res = Hash.new(0)
    cards.each { |card| res[card.suit] += 1 }
    res
  end

end
