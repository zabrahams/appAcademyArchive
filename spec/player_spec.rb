require "rspec"
require "player"

describe Player do
  subject(:player) { Player.new(100) }

  describe "initializes" do

    it "with an empty hand" do
      expect(player.hand).to be nil
    end

    it "with a pot" do
      expect(player.pot).to eq(100)
    end
  end

end
