require "./tile"

class Board

  NUM_BOMBS = 10
  HEIGHT = 9
  WIDTH = 9

  attr_accessor :saved_time

  def initialize
    @saved_time = 0

    @board = Array.new(HEIGHT) { Array.new(WIDTH) { Tile.new } }
    HEIGHT.times do |y|
      WIDTH.times do |x|
        self[x, y].get_neighbors([x, y], self)
      end
    end
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

  private

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

  def render_board
    rendered_board = "  #{(0...WIDTH).to_a.join(" ")}\n"

    @board.each_with_index do |row, index|
      rendered_board << "#{index} "
      row.each do |tile|
        rendered_board << tile.render
      end
      rendered_board << "\n"
    end

    rendered_board
  end
end
