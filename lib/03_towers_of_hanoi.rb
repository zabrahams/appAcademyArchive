class EmptyTowerError < StandardError
end

class DiskOrderError < StandardError
end

class InvalidInputError < StandardError
end

class TowersOfHanoi

  def self.setup_board
    [(1..3).to_a.reverse, [], []]
  end

  attr_accessor :board

  def initialize
    @board = TowersOfHanoi.setup_board
  end

  def move(start, fin)
    if board[start].empty?
      raise EmptyTowerError.new "There's no disk on that tower!"
    end

    if !board[fin].empty? && board[start].last >= board[fin].last
      raise DiskOrderError.new "Cannot move a larger disk onto a smaller disk"
    end

    disk = board[start].pop
    board[fin] << disk
  end

  def win?
    board.first.empty? && board[1..2].any?(&:empty?)
  end

  def render
    result = ""

   (0..2).to_a.reverse.each do |i|
      result << "#{board[0][i] || " "} "
      result << "#{board[1][i] || " "} "
      result << "#{board[2][i] || " "}\n"
    end

    result
  end

  def play

    until win?
      system('clear')
      puts render
      print "Enter move: "
      input = gets.chomp
      raise InvalidInputError.new "Invalid input!" unless input =~ /\A[1-3]\,\s*[1-3]\z/
      input = input.split(",").map { |el| el.strip.to_i - 1 }
      move(input[0], input[1])
    end

    puts "You win!"
  end
end

if $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new.play
end
