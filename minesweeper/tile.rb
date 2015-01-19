class Tile

  NEIGHBORS = [ [-1, -1],
              [-1, 0],
              [-1, 1],
              [0, -1],
              [0, 1],
              [1, -1],
              [1, 0],
              [1, 1]]

  attr_reader :neighbors

  def initialize
    @bombed = false
    @revealed = false
    @flagged = false
    @neighbors = []
  end

  def bombed?
    @bombed
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  def bomb
    @bombed = true
  end

  def reveal
    @revealed = true
    @flagged = false
  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
  end

  def neighbor_bomb_count
    self.neighbors.select(&:bombed?).count
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor unless neighbors.include?(neighbor)
  end

  def reveal_neighbors
    reveal

    return if neighbor_bomb_count > 0

    neighbors.each do |neighbor|
      neighbor.reveal_neighbors unless neighbor.flagged? || neighbor.revealed?
    end
  end

  def render
    if flagged? && !revealed?
      "F "
    elsif !revealed?
      "* "
    elsif bombed?
      "X "
    else
      num_bombs = neighbor_bomb_count
      num_bombs == 0 ? "  " : "#{num_bombs} "
    end
  end

  def get_neighbors(pos, board)
    height, width = board.class::HEIGHT, board.class::WIDTH
    x, y = pos
    NEIGHBORS.each do |diff|
      dx, dy = diff

      next unless ((x + dx).between?(0, width - 1) &&
                   (y + dy).between?(0, height - 1))

      self.add_neighbor(board[x + dx, y + dy])
    end
  end



end
