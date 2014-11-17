class Tile

  attr_reader :bombed, :revealed, :marked

  def initialize
    @bombed = false
    @revealed = false
    @marked = false
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

  def neighbors
  end

  def neighbor_bomb_count
    bomb_count = 0
    bomb_count += 1 if self.neighbors.bombed
    bomb_count
  end


end
