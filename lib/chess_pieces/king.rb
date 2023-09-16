require_relative 'pieces'

class King < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = king_symbol
  end

  private
  def move_set
    [[1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,1], [-1,-1]] 
  end
end
