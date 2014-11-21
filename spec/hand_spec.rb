require "rspec"
require "hand"

describe Hand do
  let(:card1) { Card.new(:hearts, :ace) }
  let(:card2) { Card.new(:hearts, :king) }
  let(:card3) { Card.new(:hearts, :queen) }
  let(:card4) { Card.new(:hearts, :jack) }
  let(:card5) { Card.new(:hearts, :ten) }
  let(:cards) { [card1, card2, card3, card4, card5]}
  let(:deck) { double("deck", :draw => cards) }
  subject(:hand) { Hand.new(deck) }

  it "should have five unique cards" do
    expect(hand.cards.uniq.count).to eq(5)
  end

  describe "#draw" do
    it "should add cards to the hand" do
      allow(deck).to receive(:draw).with(2).and_return(cards[0..1])
      hand.cards = []
      hand.draw(deck, 2)
      expect(hand.cards).to eq([card1, card2])
    end
  end

  describe "#discard" do
    it "should remove cards from the hand" do
      hand.discard([0, 1])
      expect(hand.cards.include?(card1)).to be false
    end
  end

  describe "#is_pair?" do
    it "should identify a pair" do
      
    end


end
