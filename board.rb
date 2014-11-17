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

  private

  def get_neighbors
    @board.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        neighbors = []
        NEIGHBORS.each do |el|
          next if @board[x + el[0]][y + el[1]].nil?
          neighbors << @board[[x + el[0]][y + el[1]]
        end
        neighbors.each { |neighbor| tile.add_neighbor(neighbor) }
      end
    end
  end
end
