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
    @board = Array.new(HEIGHT) { Array.new(WIDTH) { Tile.new } }
  end

  def initialize
  end

  def [](x, y)
    @board[y][x]
  end

  private

  def get_neighbors
    HEIGHT.times do |y|
      WIDTH.times do |x|
        NEIGHBORS.each do |diff|
          dx, dy = diff

          next unless ((x + dx).between?(0, WIDTH - 1) && (y + dy).between?(0, HEIGHT - 1))
          self[x,y].add_neighbor(self[x + dx, y + dy])
        end
      end
    end
  end
end
