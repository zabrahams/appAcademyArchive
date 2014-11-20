class Player
  PIECE_NAME = /\A[a-z]\d\z/
  COMMAND = /\Aq\z/

  def get_input

    begin
      input = gets.chomp.downcase
      return input if input.empty?

      if input.downcase == "q"
        puts "Exiting program."
        exit
      end

      raise InputError.new "Invalid input!" unless valid?(input)
    rescue InputError => e
      puts e.message
      puts "Please input a valid position or command."
      print ">"
      retry
    end

    if input =~ PIECE_NAME
      parse(input)
    else
      command(input)
    end
  end

  private

  def valid?(input)
    input =~ PIECE_NAME ||
    input =~ COMMAND
  end

  def parse(input)
    letters = ("a".."z").to_a
    x = letters.index(input[0])
    y = input[1].to_i + 1

    [x, y]
  end

  def command(input)
    case input
    when "q"
      exit
    end
  end

end
