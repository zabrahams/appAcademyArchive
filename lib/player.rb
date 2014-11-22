require "colorize"
require_relative "hand"

class InvalidInputError < StandardError
end

class BettingError < StandardError
end


class Player

  attr_accessor :hand, :my_bet
  attr_reader :pot, :name

  def initialize(name, pot)
    @name = name
    @hand = nil
    @pot = pot
    @fold = false
    @my_bet = 0
  end

  def fold?
    @fold
  end

  def receive_pot(new_pot)
    @pot += new_pot
  end

  def receive_hand(cards)
    @hand = Hand.new(cards)
    @fold = false
  end

  def get_discard
    system("clear")
    puts "#{name}'s hand: #{hand.render}"
    puts "Please write the indices of the cards you would"
    puts "like to discard, seperated by commas."
    begin
      print ">".blink
      indices = gets.chomp
      unless indices =~ /\A([0-4]\s*\,\s*)*([0-4])?\z/
        raise InvalidInputError.new "You input an illegal character."
      end
      indices = indices.split(",").map(&:to_i)
      validate_indices(indices)
    rescue InvalidInputError => e
      puts e.message
      puts "Please attempt your input again."
      retry
    end

    return indices
  end

  def bet_response(bet)
    begin
      system("clear")
      puts "#{name}'s hand: #{hand.sort!.render}"
      puts "#{name} has $#{pot}."
      puts "The current bet is #{"$#{bet}".red}."
      puts "Would you like to (f)old, (s)ee, or (r)aise?"
      # should add "all-in"
      print ">".blink
      response = gets.chomp.downcase

      unless response =~ /\A[f|s|r]\z/
        raise InvalidInputError.new "You entered an invalid character."
      end

      case response
      when "f"
        fold
      when "s"
        see(bet)
      when "r"
        amt = get_raise_amount
        bet_raise(bet, amt)
      end

    rescue InvalidInputError, BettingError => e
      puts e.message
      puts "Please try again."
      retry
    end
  end

  def get_raise_amount
    puts "Please input the amount you would like to raise."
    begin
      print ">".blink
      Integer(gets.chomp)
    rescue ArgumentError
      puts "Please input an integer value."
      retry
    end
  end

  def validate_indices(indices)
    unless indices.uniq == indices
      raise InvalidInputError.new "You can only discard a card once."
    end

    if indices.count > 3
      raise InvalidInputError.new "You are attempting to discard too many cards"
    end
  end

  def fold
    hand = nil
    @fold = true
    nil
  end

  def see(curr_bet)
    bet = curr_bet - my_bet
    raise BettingError.new "Not enough money!" if bet > pot
    @pot -= bet
    @my_bet = my_bet + bet
  end

  def bet_raise(curr_bet, amt)
    bet = curr_bet - my_bet
    if bet + amt > pot
      raise BettingError.new "Not enough money!"
    end
    @pot -= (bet + amt)
    @my_bet = my_bet + amt
  end

end
