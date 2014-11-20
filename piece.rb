class Piece

  UP = 1
  DOWN = -1
  RIGHT = 1
  LEFT = -1

  attr_reader :color, :directions, :king, :board
  attr_accessor :pos

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

  def possible_slides(move_type)
    x, y = pos
    possible_slides = []

    directions.each do |dy|
      [LEFT, RIGHT].each do |dx|
        potential_move = add_pos(pos, [dx, dy])
        if Board.on_board?(potential_move) && board.empty?(potential_move)
          poss_slides << potential_move
        end
      end
    end

    possible_slides
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

  def add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

end
