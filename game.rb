class Game

  attr_reader :board, :white, :black, :current_player

  def initialize(black, white)
    @white = white
    white.color = :white
    @black = black
    black.color = :black
    @board = Board.new
    @current_player = white
  end

  def play
    until board.over?
      initial_display

      begin
        start_prompt
        piece_pos = current_player.get_input
        validate_start(piece_pos)

        moves = []
        loop do
          moves_prompt
          move = current_player.get_input
          break if move.empty?

          moves << move
        end

        validate_moves_array(moves)
        board[piece_pos].perform_moves(moves)
      rescue InputError, InvalidMoveError => e
        puts e.message
        print ">"
        retry
      end

      @current_player = next_player
    end

    winner == :white ? (puts "White wins!") : (puts "Black wins!")
  end

  def validate_start(pos)
    piece = board[pos]
    unless piece
      raise InvalidMoveError.new "No piece at starting location."
    end
    unless piece.color == current_player.color
      raise InvalidMoveError.new "Trying to move opponent's piece."
    end
  end

  def validate_moves_array(moves)
    if moves.empty?
      raise InputError.new "You need to input an ending position!"
    end
  end

  def next_player
    @current_player == white ? black : white
  end

  def initial_display
    system "clear"
    board.display
    puts "It is #{@current_player.color}'s move!"
  end

  def start_prompt
    puts "What piece would you like to move?"
    print ">"
  end

  def moves_prompt
    puts "What is the next square you would like to move to."
    puts "Leave a blank line if your move is finished."
    print ">"
  end

end
