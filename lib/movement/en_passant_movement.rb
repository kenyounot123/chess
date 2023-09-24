require_relative 'basic_movement'

class EnPassantMovement < BasicMovement

  def initialize(board = nil, row = nil, column = nil)
    super
  end

  def update_pieces(board, coords)
    @board = board
    @row = coords[:row]
    @column = coords[:column]
  end

end