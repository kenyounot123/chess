require_relative 'pieces'
class Rook < Pieces
  include ChessSymbols

  def initialize(board,args)
    super(board, args)
    @symbol = rook_symbol
  end

  private 
  def move_set
    [[1,0], [-1,0], [0,1], [0,-1]] 
  end

end
