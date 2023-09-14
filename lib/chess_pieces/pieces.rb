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

  def update(board)
    puts 'hi'
  end
end

