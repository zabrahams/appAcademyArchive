require_relative "player"
require_relative "deck"

class GameInitError < StandardError
end

class Game

  attr_accessor :deck, :pot
  attr_reader :players

  def initialize(*players)
    unless players.count > 1
      raise GameInitError.new "Must have at least two players."
    end

    @players = players
    @pot = 0
    @deck = Deck.setup_deck.shuffle!

    players.each { |player| player.receive_hand(deck) }
  end

  def play_hand
    betting_round
    discard_round
    betting_round
    pay_pot(winners)
    players.each { |player| puts "#{player.name} has $#{player.pot}." }
  end

  def betting_round
    current_bet = 0
    players.each do |player|
      next if player.fold?
      new_bet = player.bet_response(current_bet)
      if new_bet
        self.pot += new_bet
        current_bet = new_bet
      end
    end
  end

  def discard_round
    players.each do |player|
      discard_indices = player.get_discard
      player.hand.discard(discard_indices)
      player.hand.draw(deck, discard_indices.count)
    end
  end

  def winners
    contenders = players.dup
    players.each do |player|
      next unless contenders.include?(player)
      contenders.each do |contender|
        next if player == contender
        contenders.delete(contender) if player.beats?(contender)
      end
    end

    contenders
  end

  def pay_pot(winners)
    num_winners = winners.count
    remainder = pot % num_winners
    winnings = (pot - remainder) / num_winners

    winners.each { |winner| winner.receive_pot(winnings) }
    self.pot = remainder
  end

end

if $PROGRAM_NAME == __FILE__
  alf = Player.new("Alf", 100)
  six = Player.new("Six", 100)
  urkel = Player.new("Urkel", 100)
  game = Game.new(alf, six, urkel)
  game.play_turn
end
