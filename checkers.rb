# encoding: utf-8

require "./make_checker_board.rb"
require "colorize"
require "./testing_pos.rb"   # For testing and debugging. Comment out for real game.
require "./errors.rb"
require "./piece.rb"
require "./board.rb"
require "./player.rb"
require "./game.rb"

if $PROGRAM_NAME == __FILE__
  p1 = Player.new
  p2 = Player.new
  g = Game.new(p1, p2)
  g.play
end
