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

  describe "#pair?" do
    let(:pair) { [Card.new(:clubs, :ten), card5] }
    let(:triplet) { [Card.new(:clubs, :ten), card5, card5] }

    it "should identify a pair" do
      hand.cards = pair
      expect(hand.pair?).to be true
    end

    it "should return false for a triplet" do
      hand.cards = triplet
      expect(hand.pair?).to be false
    end

    it "should modify hand.value" do
      hand.cards = pair
      hand.pair?
      expect(hand.value).to eq(1)
    end
  end

  describe '#triplet?' do
    let(:triplet) { [Card.new(:clubs, :ten), card5, card5] }
    let(:quad) { [Card.new(:clubs, :ten), card5, card5, card5] }

    it "should identify a triplet" do
      hand.cards = triplet
      expect(hand.triplet?).to be true
    end

    it "should return false for a quad" do
      hand.cards = quad
      expect(hand.triplet?).to be false
    end

    it "should modify hand.value" do
      hand.cards = triplet
      hand.triplet?
      expect(hand.value).to eq(2)
    end

  end

  describe '#quad?' do
    let(:triplet) { [Card.new(:clubs, :ten), card5, card5] }
    let(:quad) { [Card.new(:clubs, :ten), card5, card5, card5] }

    it "should identify a quad" do
      hand.cards = quad
      expect(hand.quad?).to be true
    end

    it "should return false for a triplet" do
      hand.cards = triplet
      expect(hand.quad?).to be false
    end

    it "should modify hand.value" do
      hand.cards = quad
      hand.quad?
      expect(hand.value).to eq(6)
    end

  end

  describe '#full_house?' do
    let(:full_house) { [card1, card1, card1, card2, card2] }

    it "should identify a full house" do
      hand.cards = full_house
      expect(hand.full_house?).to be true
    end

    it "should modify hand.value" do
      hand.cards = full_house
      hand.full_house?
      expect(hand.value).to eq(5)
    end

  end

  describe '#flush?' do

    it "should identify a flush" do
      expect(hand.flush?).to be true
    end

    it "should modify hand.value" do
      hand.flush?
      expect(hand.value).to eq(4)
    end

  end

  describe '#straight?' do
    let(:all_tens) { [card5, card5, card5, card5, card5] }

    it "should identify a straight" do
      expect(hand.straight?).to be true
    end

    it "should return false for all tens" do
      hand.cards = all_tens
      expect(hand.straight?).to be false
    end

    it "should modify hand.value" do
      hand.straight?
      expect(hand.value).to eq(3)
    end

  end

  describe '#straight_flush?' do
    it "should identify a straight flush" do
      expect(hand.straight_flush?).to be true
    end

    it "should modify hand.value" do
      hand.straight_flush?
      expect(hand.value).to eq(7)
    end

  end

  describe '#beats?' do
    let(:full_house) { [card1, card1, card1, card2, card2] }
    let(:deck_fh) { double("deck", :draw => full_house) }
    let(:hand_fh) { Hand.new(deck_fh) }

    it "should return true when player hand is higher rank" do
      expect(hand.beats?(hand_fh)).to be true
    end

    it "should return false when player hand is lower rank" do
      expect(hand_fh.beats?(hand)).to be false
    end

    let(:card6) { Card.new(:hearts, :nine) }
    let(:deck_low_sf) { double("deck", :draw => cards[1..-1] << card6) }
    let(:hand_low_sf) { Hand.new(deck_low_sf) }

    it "should return false for lower straight_flush" do
      expect(hand.beats?(hand_low_sf)).to be true
    end
  end



end
