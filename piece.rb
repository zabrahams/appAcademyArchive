class Piece

  UP = 1
  DOWN = -1


  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
    @directions = (color == :white ? [UP] : [DOWN])
  end

  def perform_slide(pos)
  end

  def perform_jump
  end

  def move_diffs
  end

  def should_promote?
  end

  def promote
  end


end
