
class Knight 
  include ChessSymbols
  attr_accessor :move_set, :location, :color, :symbol
  def initialize(location, color, symbol = nil)
    @location = location
    @move_set = [
      [1,2], [-1,2], [-1,-2], [1,-2], [2,1], [-2,1], [-2,-1], [2,-1]
    ]
    @color = color
    @symbol = color == 'white' ? white_knight : black_knight
  end

  def all_possible_moves(start = @location, result=[]) 
    @move_set.each do |move|
      rank = start[0] + move[0]
      file = start[1] + move[1]
      result << [rank,file] if rank.between?(0,7) && file.between?(0,7)
    end
    result
  end

end