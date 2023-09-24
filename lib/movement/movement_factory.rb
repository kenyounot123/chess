#This class creates the type of movement that updates the board.
class MovementFactory
  def initialize(type)
    @movement_class = self.class.const_get("#{type}Movement")
  end

  def build
    @movement_class.new
  end


end