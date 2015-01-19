require "rspec"
require "hand"

describe Hand do
  let(:card1) { Card.new(:hearts, :ace) }
  let(:card2) { Card.new(:hearts, :king) }
  let(:card3) { Card.new(:hearts, :queen) }
  let(:card4) { Card.new(:hearts, :jack) }
  let(:card5) { Card.new(:hearts, :ten) }
  let(:card6) { Card.new(:hearts, :nine)}
  let(:cards) { [card1, card2, card3, card4, card5]}
  subject(:hand) { Hand.new(cards) }

  it "should have five unique cards" do
    expect(hand.cards.uniq.count).to eq(5)
  end

  describe "#draw" do
    let(:deck) { double("deck", :draw => [card1, card2]) }
    it "should add cards to the hand" do
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
    let(:pair_hand) { Hand.new(pair)}
    let(:triplet_hand) { Hand.new(triplet) }

    it "should identify a pair" do
      expect(pair_hand.pair?).to be true
    end

    it "should modify hand.value" do
      pair_hand.pair?
      expect(pair_hand.value).to eq(1)
    end

    it "should return false for a triplet" do
      expect(triplet_hand.pair?).to be false
    end
  end

  describe '#two_pair' do
    let(:two_pair) { [card1, card1, card2, card2, card3] }
    let(:two_pair_hand) { Hand.new(two_pair) }

    it "should identify a two_ pair" do
      expect(two_pair_hand.two_pair?).to be true
    end

    it "should modify hand.value" do
      two_pair_hand.two_pair?
      expect(two_pair_hand.value).to eq(2)
    end
  end

  describe '#triplet?' do
    let(:triplet) { [card1, card2, card5, card5, card5] }
    let(:quad) { [card1, card5, card5, card5, card5] }
    let(:triplet_hand) { Hand.new(triplet)}
    let(:quad_hand) { Hand.new(quad)}

    it "should identify a triplet" do
      expect(triplet_hand.triplet?).to be true
    end

    it "should modify hand.value" do
      triplet_hand.triplet?
      expect(triplet_hand.value).to eq(3)
    end

    it "should return false for a quad" do
      quad_hand.cards = quad
      expect(quad_hand.triplet?).to be false
    end
  end

  describe '#quad?' do
    let(:triplet) { [card1, card2, card5, card5, card5] }
    let(:quad) { [card1, card5, card5, card5, card5] }
    let(:triplet_hand) { Hand.new(triplet)}
    let(:quad_hand) { Hand.new(quad)}

    it "should identify a quad" do
      expect(quad_hand.quad?).to be true
    end

    it "should modify hand.value" do
      quad_hand.quad?
      expect(quad_hand.value).to eq(7)
    end

    it "should return false for a triplet" do
      triplet_hand.cards = triplet
      expect(triplet_hand.quad?).to be false
    end
  end

  describe '#full_house?' do
    let(:full_house) { [card1, card1, card1, card2, card2] }
    let(:fh_hand) { Hand.new(full_house)}

    it "should identify a full house" do
      expect(fh_hand.full_house?).to be true
    end

    it "should modify hand.value" do
      fh_hand.full_house?
      expect(fh_hand.value).to eq(6)
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
      tens_hand = Hand.new(all_tens)
      expect(tens_hand.straight?).to be false
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
    let(:f_h_hand) { Hand.new(full_house) }

    it "should return true when player hand is higher rank" do
      expect(hand.beats?(f_h_hand)).to be true
    end

    it "should return false when player hand is lower rank" do
      expect(f_h_hand.beats?(hand)).to be false
    end

    let(:hand_low_sf) { Hand.new(cards[1..-1] << card6) }

    it "should return true for lower straight_flush" do
      expect(hand.beats?(hand_low_sf)).to be true
    end

    let(:high_quad) { Hand.new(([card1] * 4) << card4) }
    let(:low_quad) { Hand.new(([card2] * 4) << card4) }

    it "should return true for higher quad" do
      expect(high_quad.beats?(low_quad)).to be true
    end

    let (:high_kick_hand) { Hand.new([card1, card1, card2, card2, card3])}
    let (:low_kick_hand) { Hand.new([card1, card1, card2, card2, card4])}

    it "should return true for two pair with higher kicker." do
      expect(high_kick_hand.beats?(low_kick_hand)).to be true
    end

    let (:high_pair_hand) { Hand.new([card1, card1, card2, card3, card4]) }
    let (:low_pair_hand) { Hand.new([card1, card2, card2, card3, card4]) }

    it "should return false for lower pair" do
      expect(low_pair_hand.beats?(high_pair_hand)).to be false
    end

    context "edge cases" do
      let(:card1) { Card.new(:spades, :deuce)}
      let(:card2) { Card.new(:spades, :three)}
      let(:card3) { Card.new(:hearts, :four)}
      let(:card4) { Card.new(:hearts, :five)}
      let(:card5) { Card.new(:diamonds, :six)}
      let(:card6) { Card.new(:diamonds, :seven)}

      let(:low_house_hand) { Hand.new([card5, card5, card1, card1, card1]) }
      let(:high_house_hand) { Hand.new([card4, card4, card4, card2, card2]) }

      it "should return false for the full hand with three deuces" do
        expect(low_house_hand.beats?(high_house_hand)).to be false
      end

      let(:low_card_hand) { Hand.new([card1, card3, card4, card5, card6]) }
      let(:high_card_hand) { Hand.new([card2, card3, card4, card5, card6]) }

      it "should return true for lowest card higher" do
        expect(high_card_hand.beats?(low_card_hand)).to be true
      end

      it "should return nil for a true tie" do
        expect(low_card_hand.beats?(low_card_hand)).to be nil
      end
    end
  end

end
