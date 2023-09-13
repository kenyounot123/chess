class Bishop 
  include ChessSymbols
  attr_accessor :move_set, :location, :color, :symbol
  def initialize(location, color, symbol = nil)
    @location = location
    @move_set = []
    @color = color
    @symbol = color == 'white' ? white_bishop : black_bishop
    @symbol
  end
end