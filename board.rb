# frozen_string_literal: true

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
    return "Cell already set #{@grid[row][col]}'" unless @grid[row][col].nil?

    @grid[row][col] = symbol if @grid[row][col].nil?
  end

  def evaluate_all
    result = evaluate(@grid, 'row')
    return result unless result.empty?

    result = evaluate(@grid.transpose, 'col')
    return result unless result.empty?

    result = evaluate_diag(@grid.map(&:reverse), 'diag_downup')
    return result unless result.empty?

    result = evaluate_diag(@grid, 'diag_updown')
    return result unless result.empty?
  end

  def evaluate(array, string)
    hash = {}
    array.each_with_index do |row, index|
      # evaluating rows
      hash["#{string} #{index}"] = row.uniq[0] if row.uniq.length == 1 && !row.uniq[0].nil?
    end
    hash
  end

  def evaluate_diag(matrix, string)
    hash = {}
    result_array = matrix.each_with_index.reduce([]) do |array, (row, index)|
      array.push(row[index])
      array
    end
    hash[string] = result_array.uniq[0] if result_array.uniq.length == 1 && !result_array.uniq[0].nil?
    hash
  end
end
