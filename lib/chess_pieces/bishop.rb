require_relative 'pieces'

class Bishop < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = bishop_symbol
  end
end