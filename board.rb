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
    get_neighbors
    seed_board
  end

  def initialize
  end

  def [](x, y)
    @board[y][x]
  end

  def display
    puts render_board
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

  def seed_board
    placed = 0
    while placed <= 10
      tile = @board.flatten.sample
      unless tile.bombed
        tile.bomb
        placed += 1
      end
    end
  end

  def render_board
    rendered_board = ""
    @board.each do |row|
      row.each do |square|
        if square.marked && !square.revealed
          rendered_board << "F "
        elsif !square.revealed
          rendered_board << "* "
        else
          num_bombs = square.neighbor_bomb_count
          num_bombs == 0 ? (rendered_board << "_ ") : (rendered_board << "#{num_bombs} ")
        end
      end
      rendered_board << "\n"
    end
    rendered_board
  end
end
