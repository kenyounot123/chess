require_relative 'pieces'
class Rook < Pieces
  include ChessSymbols

  def initialize(board,args)
    super(board, args)
    @symbol = rook_symbol
  end

end
