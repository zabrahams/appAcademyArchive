class Piece

  UP = 1
  DOWN = -1
  RIGHT = 1
  LEFT = -1

  attr_reader :color, :directions, :king, :board
  attr_accessor :pos

  def initialize(pos, color, board, king)
    @pos = pos
    @color = color # Maybe raise an error if the wrong color is used...
    @board = board
    @king = king
    @directions = (color == :white ? [UP] : [DOWN])
  end

  def perform_slide(end_pos)
    if possible_slides.include?(end_pos)
      board.slide(pos, end_pos)
      true
    else
      false
    end
  end

  def perform_jump(end_pos)
    x, y = pos
    if possible_jumps.include?(end_pos)
      dx = (end_pos[0] - x)/2
      dy = (end_pos[1] - y)/2
      jump_pos = add_pos(pos, [dx, dy])

      board.jump(pos, jump_pos, end_pos)
      true
    else
      false
    end
  end

  def perform_moves!(sequence)
    if sequence.count == 1
      move = sequence.shift
      if !perform_slide(move) && !perform_jump(move)
        raise InvalidMoveError "Sequence consists of an invalid move."
      end
    else
      until sequence.empty?
        move = sequence.shift
        unless perform_jump(move)
          raise InvalidMoveError "Sequence contains an invalid move."
        end
      end
    end
  end

  def possible_slides
    x, y = pos
    possible_slides = []

    directions.each do |dy|
      [LEFT, RIGHT].each do |dx|
        new_square = add_pos(pos, [dx, dy])
        possible_slides << new_square if can_slide?(new_square)
      end
    end

    possible_slides
  end

  def possible_jumps

    # refactor into a single possible_moves method that takes the
    # relevant condition as a proc

    x, y = pos
    possible_jumps = []

    directions.each do |dy|
      [LEFT, RIGHT].each do |dx|
        jumped_square = add_pos(pos, [dx, dy])
        new_square = add_pos(jumped_square, [dx, dy])

        possible_jumps << new_square if can_jump?(jumped_square, new_square)
      end
    end

    possible_jumps
  end

  def can_jump?(jumped_square, new_square)
    (Board.on_board?(new_square)) &&
    (board.empty?(new_square)) &&
    (jumped_piece = board[jumped_square]) &&
    (jumped_piece.color != color)
  end

  def can_slide?(new_square)
    Board.on_board?(new_square) && board.empty?(new_square)
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
