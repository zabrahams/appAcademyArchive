class Piece

  UP = 1
  DOWN = -1

  attr_reader :pos, :color, :directions, :king

  def initialize(pos, color, board)
    @pos = pos
    @color = color # Maybe raise an error if the wrong color is used...
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

  def render
    color == :white ? "X" : "O"
  end

  def inspect
    x, y = pos
    "x: #{x}, y: #{y}, color: #{color}, directions: #{directions}, King: #{king}"
  end

end
