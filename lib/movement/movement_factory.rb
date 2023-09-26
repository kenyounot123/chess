#This class creates the type of movement that updates the board.
class MovementFactory
  def initialize(speciality)
    @movement_class = self.class.const_get("#{speciality}Movement")
  end

  def build
    @movement_class.new
  end


end