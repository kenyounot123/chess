require_relative 'pieces'
class Queen < Pieces
  include ChessSymbols

  def initialize(board, args)
    super(board, args)
    @symbol = queen_symbol
  end
end