class Tile

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
      reveal_neighbors(neighbor) unless neighbor.flagged? || neighbor.revealed?
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
end
