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


end
