require "rspec"
require "card"

describe Card do
  subject(:card) { Card.new(:spades, :ace) }

  it "initializes with a suit and value" do
    expect(card.suit).to eq(:spades)
    expect(card.value).to eq(:ace)
  end

  it "raises error if initialized with an invalid suit" do
    expect{Card.new(:pants, :ace)}.to raise_error(InvalidSuitError, "Cannot initialize card with that suit.")
  end

  it "raises error if initialized with an invalid value" do
    expect{Card.new(:spades, :pants)}.to raise_error(InvalidCardValueError, "Cannot initialize card with that value.")
  end

  describe "#==" do
    let(:card1) { Card.new(:spades, :ten) }
    let(:card2) { Card.new(:hearts, :ten) }
    let(:card3) { Card.new(:spades, :ace) }
    let(:card4) { Card.new(:spades, :ace) }

    it "returns true when both cards have the same suit and value" do
      expect(card3 == card4).to be true
    end

    it "returns false when the value differs" do
      expect(card3 == card1).to be false
    end
  end

  describe "#render" do
    it "renders a card property" do
      expect(card.render).to eq("A♠")
    end
  end

  describe "#n_value" do
    it "returns 14 for a :ace" do
      expect(card.n_value).to eq(14)
    end

    it "return 6 for a :six" do
      card = Card.new(:spades, :six)
      expect(card.n_value).to eq(6)
    end
  end

  describe "#<=>" do

    let(:card1) { Card.new(:spades, :eight) }
    let(:card2) { Card.new(:spades, :ten) }
    let(:card3) { Card.new(:spades, :king) }

    it "returns 1 if the first card is higher" do
      expect(card2 <=> card1).to eq(1)
    end

    it "returns 0 if the cards are equal" do
      expect(card2 <=> card2).to eq(0)
    end

    it "returns -1 if the first card is lower" do
      expect(card1 <=> card2).to eq(-1)
    end

    it "allows cards to be sorted" do
      expect([card3, card2, card1].sort).to eq([card1, card2, card3])
    end
  end

end
