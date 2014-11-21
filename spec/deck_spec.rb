require "rspec"
require "deck"

describe Deck do
  subject(:deck) { Deck.setup_deck }

  it "intializes to a length of 52" do
    expect(deck.cards.count).to eq(52)
  end

  it "has 13 of each suit" do
    suit_count = Hash.new(0)

    deck.cards.each do |card|
      suit_count[card.suit] += 1
    end

    expect(suit_count.values.all? { |suit| suit == 13 }).to be true
  end

  it "has 4 of each value" do
    value_count = Hash.new(0)

    deck.cards.each do |card|
      value_count[card.value] += 1
    end

    expect(value_count.values.all? { |value| value == 4 }).to be true
  end

  it "does not contain duplicates" do
    expect(deck.cards.uniq).to eq(deck.cards)
  end


end
