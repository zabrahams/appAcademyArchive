require "./tile"

class Board

  HEIGHT = 9
  WIDTH = 9
  NEIGHBORS = [ [-1, -1],
                [-1, 0],
                [-1, 1],
                [0, -1],
                [0, 1],
                [1, -1],
                [1, 0],
                [1, 1]]

  def make_board
    @board = Array.new(HEIGHT) { Array.new(WIDTH, Tile.new) }
  end

  def initialize
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end

  private

  def get_neighbors
    HEIGHT.times do |y|
      WIDTH.times do |x|
        neighbors = []
        NEIGHBORS.each do |diff|
          dx, dy = diff
          next if self[x + dx, y + dy].nil?
          neighbors << self[x + dx, y + dy]
        end
        neighbors.each { |neighbor| tile.add_neighbor(neighbor) }
      end
    end
  end
end
