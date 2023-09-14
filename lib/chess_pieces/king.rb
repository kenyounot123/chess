require_relative 'pieces'

class King < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = king_symbol
  end
end