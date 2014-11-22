require "rspec"
require "player"

describe Player do
  subject(:player) { Player.new(100) }

  describe "#initialize" do

    it "with an empty hand" do
      expect(player.hand).to be nil
    end

    it "with a pot" do
      expect(player.pot).to eq(100)
    end
  end

  describe "#receive_pot" do

    it "should add the recieved amount to player's pot" do
      player.receive_pot(100)
      expect(player.pot).to eq(200)
    end
  end

end
