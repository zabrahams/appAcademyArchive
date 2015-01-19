require 'rspec'
require '03_towers_of_hanoi'

describe TowersOfHanoi do
  subject(:towers) { TowersOfHanoi.new }

  describe '::setup_board' do
    let(:board) { TowersOfHanoi.setup_board }

    it "has three towers" do
      expect(board.count).to eq(3)
    end

    it "has three rings on the first tower" do
      expect(board.first.count).to eq(3)
    end

    it "create two empty towers" do
      expect(board[1..2].all?(&:empty?)).to be true
    end

    it "has disks in the right order on the first tower" do
      expect(board.first).to eq([3, 2, 1])
    end
  end

  describe '#initialize' do
    it "initializes @board to setup_board" do
      expect(towers.board).to eq(TowersOfHanoi.setup_board)
    end
  end

  describe '#move' do
    let(:board) { towers.board }

    before do
      towers.move(0, 1)
    end

    it "removes disk from starting tower" do
      expect(board.first.count).to eq(2)
    end

    it "adds disk to 2nd tower" do
      expect(board[1].count).to eq(1)
    end

    it "raises an error when you try to move a disk from an empty tower" do
      expect{towers.move(2, 1)}.to raise_error(EmptyTowerError, "There's no disk on that tower!")
    end

    it "raises an error when you try moving a larger disk onto a smaller disk" do
      expect{towers.move(0, 1)}.to raise_error(DiskOrderError, "Cannot move a larger disk onto a smaller disk")
    end
  end

  describe '#win?' do
    it "returns false when not won" do
      expect(towers.win?).to be false
    end

    it "return true when all of the disks are on either the 2nd or 3rd tower" do
      towers.board = [[], [], [3, 2, 1]]
      expect(towers.win?).to be true
    end
  end

  describe '#render' do
    it "should display the board" do
      expect(towers.render).to eq("1    \n2    \n3    \n")
    end

  end
  
end
