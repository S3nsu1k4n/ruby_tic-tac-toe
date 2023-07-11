# frozen_string_literal: true

require './player'
require './board'

BOARD_SIZE = 3
player1 = Player.new(1)
player2 = Player.new(2)
board = Board.new(BOARD_SIZE)

board.show

result = board.evaluate_all

while result.nil?
  [player1, player2].each do |player|
    puts 'Already set' while board.set_cell(*player.make_move, player.symbol).include?('already set')
    result = board.evaluate_all
    board.show
    break unless result.nil?
  end
end
result.each do |k, v|
  puts "Player '#{v}' wins!"
  puts "Win through #{k}"
end
