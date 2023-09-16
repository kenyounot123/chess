require_relative 'pieces'
class Pawn < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = pawn_symbol
  end


  private
  def move_set
    [[0,1], [0,2]] 
  end
end