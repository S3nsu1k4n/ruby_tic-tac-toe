# frozen_string_literal: true

# represents the players
class Player
  attr_reader :symbol

  def initialize(number)
    @turn = 1
    @num = number
    @symbol = receive_player_symbol
  end

  def receive_player_symbol
    puts "Symbol for player #{@num}?"
    gets[0]
  end

  def make_move
    puts "Player #{@num}, Turn #{@turn}:"
    puts 'x y (space between)...'
    @turn += 1
    input = gets.split(' ')
    input = gets.split(' ') while input.length < 2
    input[..1].map(&:to_i)
  end
end
