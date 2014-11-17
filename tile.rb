class Tile

  attr_reader :bombed, :revealed, :marked, :neighbors

  def initialize
    @bombed = false
    @revealed = false
    @marked = false
    @neighbors = []
  end

  def bomb
    @bombed = true
  end

  def reveal
    @revealed = true
  end

  def mark
    @marked = true
  end

  def neighbor_bomb_count
    self.neighbors.select(&:bombed).count
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor
  end


end
