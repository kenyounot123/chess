require_relative '../lib/board'
require_relative '../lib/chess_symbols'
require_relative '../lib/chess_pieces/pieces'
require_relative '../lib/chess_pieces/rook'
require_relative '../lib/chess_pieces/knight'
require_relative '../lib/chess_pieces/bishop'
require_relative '../lib/chess_pieces/queen'
require_relative '../lib/chess_pieces/king'
require_relative '../lib/chess_pieces/pawn'
require_relative '../lib/movement/movement_factory'
require_relative '../lib/movement/basic_movement'
require_relative '../lib/movement/pawn_promotion_movement'
require_relative '../lib/movement/en_passant_movement'
require_relative '../lib/movement/castling_movement'

describe Board do 
  subject(:board) { described_class.new }

  describe '#initial_placements' do
    before do
      board.initial_placements
    end

    it 'has top row of black game pieces' do
      expect(board.grid[0].all? { |piece| piece.color == :black } ).to be true
    end
  end
end
