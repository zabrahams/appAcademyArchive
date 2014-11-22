require "rspec"
require "hand"

describe Hand do
  let(:card1) { Card.new(:hearts, :ace) }
  let(:card2) { Card.new(:hearts, :king) }
  let(:card3) { Card.new(:hearts, :queen) }
  let(:card4) { Card.new(:hearts, :jack) }
  let(:card5) { Card.new(:hearts, :ten) }
  let(:card6) { Card.new(:heards, :nine)}
  let(:cards) { [card1, card2, card3, card4, card5]}
  let(:deck) { double("deck", :draw => cards) }
  subject(:hand) { Hand.new(deck) }

  it "should have five unique cards" do
    expect(hand.cards.uniq.count).to eq(5)
  end

  describe "#draw" do
    it "should add cards to the hand" do
      allow(deck).to receive(:draw).with(2).and_return([card1, card2])
      hand.cards = []
      hand.draw(deck, 2)
      expect(hand.cards).to eq([card1, card2])
    end
  end

  describe "#discard" do
    it "should remove cards from the hand" do
      hand.discard([0])
      expect(hand.cards.include?(card1)).to be false
    end
  end

  describe "#pair?" do
    let(:pair) { [card1, card2, card3, card5, card5] }
    let(:triplet) { [card1, card2, card5, card5, card5] }
    before { hand.cards = pair }

    it "should identify a pair" do
      expect(hand.pair?).to be true
    end

    it "should modify hand.value" do
      hand.pair?
      expect(hand.value).to eq(1)
    end

    it "should return false for a triplet" do
      hand.cards = triplet
      expect(hand.pair?).to be false
    end
  end

  describe '#two_pair' do
    let(:two_pair) { [card1, card1, card2, card2, card3] }
    before { hand.cards = two_pair }

    it "should identify a two_ pair" do
      expect(hand.two_pair?).to be true
    end

    it "should modify hand.value" do
      hand.two_pair?
      expect(hand.value).to eq(2)
    end
  end

  describe '#triplet?' do
    let(:triplet) { [card1, card2, card5, card5, card5] }
    let(:quad) { [card1, card5, card5, card5, card5] }
    before { hand.cards = triplet }

    it "should identify a triplet" do
      expect(hand.triplet?).to be true
    end

    it "should modify hand.value" do
      hand.triplet?
      expect(hand.value).to eq(3)
    end

    it "should return false for a quad" do
      hand.cards = quad
      expect(hand.triplet?).to be false
    end
  end

  describe '#quad?' do
    let(:triplet) { [card1, card2, card5, card5, card5] }
    let(:quad) { [card1, card5, card5, card5, card5] }
    before { hand.cards = quad }

    it "should identify a quad" do
      expect(hand.quad?).to be true
    end

    it "should modify hand.value" do
      hand.quad?
      expect(hand.value).to eq(7)
    end

    it "should return false for a triplet" do
      hand.cards = triplet
      expect(hand.quad?).to be false
    end
  end

  describe '#full_house?' do
    let(:full_house) { [card1, card1, card1, card2, card2] }
    before { hand.cards = full_house }

    it "should identify a full house" do
      expect(hand.full_house?).to be true
    end

    it "should modify hand.value" do
      hand.full_house?
      expect(hand.value).to eq(6)
    end
  end

  describe '#flush?' do

    it "should identify a flush" do
      expect(hand.flush?).to be true
    end

    it "should modify hand.value" do
      hand.flush?
      expect(hand.value).to eq(5)
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
      expect(hand.value).to eq(4)
    end
  end

  describe '#straight_flush?' do
    it "should identify a straight flush" do
      expect(hand.straight_flush?).to be true
    end

    it "should modify hand.value" do
      hand.straight_flush?
      expect(hand.value).to eq(8)
    end
  end

  describe '#beats?' do
    let(:full_house) { [card1, card1, card1, card2, card2] }
    let(:f_h_deck) { double("f_h_deck", :draw => full_house) }
    let(:f_h_hand) { Hand.new(f_h_deck) }

    it "should return true when player hand is higher rank" do
      expect(hand.beats?(f_h_hand)).to be true
    end

    it "should return false when player hand is lower rank" do
      expect(f_h_hand.beats?(hand)).to be false
    end

    let(:deck_low_sf) { double("low_sf_deck", :draw => cards[1..-1] << card6) }
    let(:hand_low_sf) { Hand.new(deck_low_sf) }

    it "should return true for lower straight_flush" do
      expect(hand.beats?(hand_low_sf)).to be true
    end

    let(:high_quad_deck) { double("high_quad_deck", :draw => ([card1] * 4) << card4)}
    let(:high_quad) { Hand.new(high_quad_deck) }

    let(:low_quad_deck) { double("high_quad_deck", :draw => ([card2] * 4) << card4)}
    let(:low_quad) { Hand.new(low_quad_deck) }

    it "should return true for higher quad" do
      expect(high_quad.beats?(low_quad)).to be true
    end

    let (:high_kick_deck) do
      double("high_kicker_deck",:draw => ([card1, card1, card2, card2, card3]))
    end
    let (:high_kick_hand) { Hand.new(high_kick_deck)}
    let (:low_kick_deck) do
      double("low_kicker_deck",:draw => ([card1, card1, card2, card2, card4]))
    end
    let (:low_kick_hand) { Hand.new(low_kick_deck)}

    it "should return true for two pair with higher kicker." do
      expect(high_kick_hand.beats?(low_kick_hand)).to be true
    end

    let (:high_pair_deck) do
      double("high_pair_deck", :draw => [card1, card1, card2, card3, card4])
    end
    let (:high_pair_hand) { Hand.new(high_pair_deck) }
    let (:low_pair_deck) do
      double("low_pair_deck", :draw => [card1, card2, card2, card3, card4])
    end
    let (:low_pair_hand) { Hand.new(low_pair_deck) }

    it "should return false for lower pair" do
      expect(low_pair_hand.beats?(high_pair_hand)).to be false
    end

    let(:card1) { Card.new(:spades, :deuce)}
    let(:card2) { Card.new(:spades, :three)}
    let(:card3) { Card.new(:hearts, :four)}
    let(:card4) { Card.new(:hearts, :five)}
    let(:card5) { Card.new(:diamonds, :six)}
    let(:card6) { Card.new(:diamonds, :seven)}

    let(:low_card_deck) do
      double("low_card_deck", :draw => [card1, card3, card4, card5, card6])
    end
    let(:low_card_hand) { Hand.new(low_card_deck) }
    let(:high_card_deck) do
      double("high_card_deck", :draw => [card2, card3, card4, card5, card6])
    end
    let(:high_card_hand) { Hand.new(high_card_deck) }

    it "should return true for lowest card higher" do
      expect(high_card_hand.beats?(low_card_hand)).to be true
    end

    it "should return nil for a true tie" do
      expect(low_card_hand.beats?(low_card_hand)).to be nil
    end
  end

end
