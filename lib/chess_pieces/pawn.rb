class Pawn
  attr_accessor :move_set, :location, :color, :symbol
  include ChessSymbols
  def initialize(location, color, symbol = nil)
    @location = location
    @move_set = []
    @color = color
    @symbol = color == 'white' ? white_pawn : black_pawn
    @symbol
  end
end