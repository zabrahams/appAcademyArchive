require "./tile"

class Board

  NUM_BOMBS = 10
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

  def initialize
    @board = Array.new(HEIGHT) { Array.new(WIDTH) { Tile.new } }
    get_neighbors
    seed_board
  end

  def [](x, y)
    @board[y][x]
  end

  def display
    puts render_board
  end


def count_flagged
  count = 0
  @board.flatten.each do |tile|
    if tile.flagged?
      count += 1
    end
  end

  count
end

def count_revealed
  count = 0
  @board.flatten.each do |tile|
    if tile.revealed?
      count += 1
    end
  end

  count
end

  # def count_flagged_and_revealed #move into board
  #   flag_and_reveal = {:flagged => 0, :revealed => 0}
  #   Board::HEIGHT.times do |y|  #Grid.flatten.each
  #     Board::WIDTH.times do |x|
  #       if @board[x, y].flagged     #make these methods ?
  #         flag_and_reveal[:flagged] += 1
  #       elsif @board[x, y].revealed
  #         flag_and_reveal[:revealed] += 1
  #       end
  #     end
  #   end
  #
  #   flag_and_reveal
  # end

  private

  def get_neighbors #have a method in tile that grabs tiles
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
    while placed < NUM_BOMBS
      tile = @board.flatten.sample
      unless tile.bombed?
        tile.bomb
        placed += 1
      end
    end
  end

  def render_board #break out a tile render method
    rendered_board = "  0 1 2 3 4 5 6 7 8\n"
    @board.each_with_index do |row, index|
      rendered_board << "#{index} "
      row.each do |square|
        if square.flagged? && !square.revealed?
          rendered_board << "F "
        elsif !square.revealed?
          rendered_board << "* "
        elsif square.bombed?
          rendered_board << "X "
        else
          num_bombs = square.neighbor_bomb_count
          num_bombs == 0 ? (rendered_board << "  ") : (rendered_board << "#{num_bombs} ")
        end
      end
      rendered_board << "\n"
    end
    rendered_board
  end
end
