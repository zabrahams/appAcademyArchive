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
    @marked = false
  end

  def mark
    @marked = true
  end

  def unmark
    @marked = false
  end

  def neighbor_bomb_count
    self.neighbors.select(&:bombed).count
  end

  def add_neighbor(neighbor)
    @neighbors << neighbor unless neighbors.include?(neighbor)
  end


end
