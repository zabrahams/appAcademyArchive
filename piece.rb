# encoding: utf-8

class Piece

  UP = 1
  DOWN = -1
  RIGHT = 1
  LEFT = -1
  SLIDE = 1
  JUMP = 2

  attr_reader :color, :directions, :king, :board
  attr_accessor :pos

  def initialize(pos, color, board, king)
    @pos = pos
    @color = color # Maybe raise an error if the wrong color is used...
    @board = board
    @king = king
    if king
      @directions = [UP, DOWN]
    else
      @directions = (color == :white ? [UP] : [DOWN])
    end
  end

  def perform_slide(end_pos)
    p "sliding to #{end_pos}"
    can_slide_proc = Proc.new { |square| can_slide?(square) }

    if possible_moves(SLIDE, &can_slide_proc).include?(end_pos)
      board.slide(pos, end_pos)
      promote if should_promote?
      true
    else
      false
    end
  end

  def perform_jump(end_pos)
    can_jump_proc = Proc.new { |square| can_jump?(square) }

    x, y = pos
    if possible_moves(JUMP, &can_jump_proc).include?(end_pos)
      jump_pos = square_between(pos, end_pos)

      board.jump(pos, jump_pos, end_pos)
      promote if should_promote?
      true
    else
      false
    end
  end

  def perform_moves!(seq)
    if seq.count == 1
      move = seq.shift
      p "Slide/Jump #{move}"
      if !perform_slide(move) && !perform_jump(move)
        raise InvalidMoveError.new "Sequence consists of an invalid move."
      end
    else
      until seq.empty?
        move = seq.shift
        p "Jump #{move}"
        unless perform_jump(move)
          raise InvalidMoveError.new "Sequence contains an invalid move."
        end
      end
    end
  end

  def perform_moves(seq)
    unless valid_move_seq?(seq)
      raise InvalidMoveError.new "Not a valid move sequence."
    end

    perform_moves!(seq)
  end

  def valid_move_seq?(seq)
    test_board = board.dup
    test_piece = test_board[pos]

    begin
      test_piece.perform_moves!(seq.dup)
    rescue InvalidMoveError
      false
    else
      true
    end
  end

  def possible_moves(multiplier, &requirement)
    possible_slides = []

    directions.each do |dy|
      [LEFT, RIGHT].each do |dx|
        new_square = add_pos(pos, [multiplier * dx, multiplier * dy])
        possible_slides << new_square if requirement.call(new_square)
      end
    end

    possible_slides
  end

  def can_jump?(new_square)
    jumped_square = square_between(pos, new_square)

    (Board.on_board?(new_square)) &&
    (board.empty?(new_square)) &&
    (jumped_piece = board[jumped_square]) &&
    (jumped_piece.color != color)
  end

  def can_slide?(new_square)
    Board.on_board?(new_square) && board.empty?(new_square)
  end

  def should_promote?
    return false if king

    y = pos[1]
    y == ((Board::BOARD_SIZE - 1) / 2.0) +
         (((Board::BOARD_SIZE - 1)/ 2.0) *
         @directions.first)
  end

  def promote
    @king = true
    @directions = [UP, DOWN]
  end

  def render
    if king
      color == :white ? "\u2688".red : "\u2688".cyan
    else
      color == :white ? "\u2687".red : "\u2687".cyan
    end
  end

  def inspect
    x, y = pos
    "x: #{x}, y: #{y}, color: #{color}, directions: #{directions}, King: #{king}"
  end

  def add_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

  def square_between(pos1, pos2)
    dx = (pos2[0] - pos1[0])/2
    dy = (pos2[1] - pos1[1])/2
    add_pos(pos1, [dx, dy])
  end

end
