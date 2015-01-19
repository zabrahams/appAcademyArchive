require "rspec"
require "game"

describe Game do
  let(:p1) { double("player1", :receive_hand => nil) }
  let(:p2) { double("player2", :receive_hand => nil) }
  let(:p3) { double("player3", :receive_hand => nil) }
  subject(:game) { Game.new(p1, p2, p3) }


  describe "#intialize" do
    let(:two_player_game) { Game.new(p1, p2) }

    it "raises an error if initialized with one player." do
      expect { Game.new(p1) }
      .to raise_error(GameInitError, "Must have at least two players.")
    end

    it "initializes with an arbitray number of players" do
      expect(two_player_game.players.count).to eq(2)
      expect(game.players.count).to eq(3)
    end

    it "has a deck" do
      expect(game.deck).to_not be nil
    end

    it "starts with an empty pot" do
      expect(game.pot).to eq(0)
    end
  end

end
