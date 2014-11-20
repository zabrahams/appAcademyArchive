class Game

  attr_reader :board, :white, :black

  def initialize(black, white)
    @white = white
    @black = black
    @board = Board.new
  end

  def play
    until board.over?
      [white, black].each do |curr_player|
        system "clear"
        board.display

        begin
          puts "What piece would you like to move?"
          print ">"
          piece_pos = curr_player.get_input
        rescue InputError => e
          puts e.message
          retry
        end

        begin
          moves = []
          loop do
            puts "What is the next square you would like to move to."
            puts "Leave a blank line if your move is finished."

            move = curr_player.get_input
            break if move.empty?

            moves << move
          end
          raise InputError.new "You need to input an ending position!" if moves.empty?
        rescue InputError => e
          puts e.message
          retry
        end

        board[piece_pos].perform_moves(moves)
        break if board.over?
      end
    end

    winner == :white ? (puts "White wins!") : (puts "Black wins!")
  end

end
