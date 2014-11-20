class Player
  PIECE_NAME = /\A[a-z]\d\z/
  COMMAND = /\Aq\z/

  def get_input
    input = gets.chomp
    return input if input.empty?
    input.split(",").map(&:to_i)
  end

  private

  def valid_input?
  end

end
