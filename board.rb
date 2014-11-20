require 'piece.rb'

class Board

  BOARD_SIZE = 8
  ROWS_OF_PIECES = 3

  def self.starting_position
    position = { :white => [], :black => [] }

    (0...BOARD_SIZE).each do |x|
      (0...ROWS_OF_PIECES).each do |y|
        white_square = [x, y]
        black_square = [x, BOARDSIZE - y]
        position[:white] << white_square if Board.is_dark(white_square)
        position[:black] << black_square if Board.is_dark(black_square)
      end
    end

    position
  end

  def self.is_dark(pos)
    x, y = pos
    (x + y) % 2 == 0
  end

  def initialize
  end

  def make_board(position)
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }


end
