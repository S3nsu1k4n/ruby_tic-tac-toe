# frozen_string_literal: true

# represents the game itself
class Game
  def initialize
    #@player1 = Player.new
    #@player2 = Player.new
    @board_size = 3
    @board = Board.new(@board_size)
    @board.set_cell(1, 1, 'X')
    @board.set_cell(0, 2, 'O')
    @board.set_cell(0, 1, 'O')
    @board.set_cell(0, 0, 'X')
    @board.set_cell(1, 0, 'O')
    @board.set_cell(2, 0, 'O')
    @board.set_cell(2, 2, 'X')
    @board.show
    p @board.evaluate_all
    #p player_wins?(1)
  end

  def player_wins?(player)
    @board.evaluate['O'] >= @board_size
  end
end

# represents the board of the game (grid)
class Board
  def initialize(grid_size = 3)
    @grid_size = grid_size
    @grid = create_grid(grid_size)
  end

  def create_grid(size)
    Array.new(size) { Array.new(size) }
  end

  def show
    @grid.each { |row| p row }
  end

  def set_cell(row, col, symbol)
    unless @grid[row][col].nil?
      raise "Cell already set #{@grid[row][col]}'"
    end

    @grid[row][col] = symbol if @grid[row][col].nil?
  end

  def evaluate_all
    result = evaluate(@grid, 'row')
    return result unless result.empty?

    result = evaluate(@grid.transpose, 'col')
    return result unless result.empty?

    result = evaluate_diag
    return result unless result.empty?

  end

  def evaluate(array, string)
    hash = {}
    array.each_with_index do |row, index|
      # evaluating rows
      if row.uniq.length == 1 and !row.uniq[0].nil?
        hash["#{string} #{index}"] = row.uniq[0]
      end
    end
    hash
  end

  def evaluate_diag
    hash = {}
    array = (0..@grid.length-1).reduce([]) do |array, i|
      array[i] = @grid[i][i]
      array
    end

    if array.uniq.length == 1 and !array.uniq[0].nil?
      hash['dia_updown'] = array.uniq[0]
      return hash
    end

    j = @grid.length-1
    array = (0..@grid.length-1).reduce([]) do |array, i|
      array[i] = @grid[i][j]
      j-=1
      array
    end
    if array.uniq.length == 1 and !array.uniq[0].nil?
      hash['dia_downup'] = array.uniq[0]
      return hash
    end
    hash
  end

end

# represents the players
class Player
  @@player_number = 1
  def initialize
    @symbol = receive_player_symbol
    @num = @@player_number
    @@player_number += 1
  end

  def receive_player_symbol
    puts "Symbol for player #{@@player_number}?"
    gets
  end

  def make_move
    
  end
end
