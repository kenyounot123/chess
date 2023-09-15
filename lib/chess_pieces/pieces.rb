require_relative '../board'

class Pieces 
  attr_reader :color, :location, :symbol, :moves, :captures, :moved
  def initialize(board, args)
    board.add_observer(self)
    @color = args[:color]
    @location = args[:location]
    @moves = []
    @captures = []
    @moved = false
    @symbol = nil
  end

  #THIS NEEDS TO BE CHANGED, IT IS CURRENTLY PLACEHOLDER
  def update(board)
    puts 'hi'
  end

  def valid_location?(row, column)
    row.between?(0,7) && column.between?(0,7)
  end

  def update_location(row, column)
    @location = [row, column]
    @moved = true
  end
end

