require './piece.rb'

class Board

  BOARD_SIZE = 8
  ROWS_OF_PIECES = 3

  def self.starting_position
    position = { :white => [], :black => [] }

    (0...BOARD_SIZE).each do |x|
      (0...ROWS_OF_PIECES).each do |y|
        white_square = [x, y]
        black_square = [x, BOARD_SIZE - y - 1]
        position[:white] << white_square if Board.is_dark?(white_square)
        position[:black] << black_square if Board.is_dark?(black_square)
      end
    end

    position
  end

  def self.is_dark?(pos)
    x, y = pos
    (x + y) % 2 == 0
  end

  def self.on_board?(pos)
    pos.all? { |coord| coord.between?(0, BOARD_SIZE - 1) }
  end

  def initialize(position = Board.starting_position)
    @grid = make_board(position)
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[y][x] = piece
    piece.pos = pos if piece
  end

  def slide(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def jump(start_pos, jump_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[jump_pos] = nil
  end

  def dup

  end

  def extract_position
    position = {}
    position[:white] = pieces(:white).map { |piece| piece.pos.dup }
    position[:black] = pieces(:black).map { |piece| piece.pos.dup }
    position
  end

  def pieces(color = nil)
    pieces = @grid.flatten.compact
    if color == :white
      pieces.select { |piece| piece.color == :white }
    elsif color == :black
      pieces.select { |piece| piece.color == :black }
    else
      pieces
    end
  end

  def empty?(pos)
    self[pos].nil?
  end

  def make_board(position)
    grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    position.each do |color, squares|
      squares.each do |square|
        x, y = square
        grid[y][x] = Piece.new(square, color, self)
      end
    end

    grid
  end

  def render
    @grid.reverse.map do |row|
      row.map do |square|
        p square
        square ? " #{square.render} " : " _ "
      end.join("")
    end.join("\n")
  end

  def display
    puts render
  end

  def inspect
    render
  end

end
