require_relative 'pieces'
class Pawn < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = pawn_symbol
  end
end