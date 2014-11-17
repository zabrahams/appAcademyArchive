require "./tile"

class Board

  HEIGHT = 9
  WIDTH = 9

  def self.make_board
    Array.new(HEIGHT) { Array.new(WIDTH, Tile.new) }
  end

  def initialize
  end


end
