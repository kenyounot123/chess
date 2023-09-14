
require_relative 'board'
require_relative 'displayable'
require_relative 'chess_symbols'
require_relative 'chess_pieces/pieces'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/pawn'
require_relative 'notation_translator'

game = Board.new
game.initial_placements
game.to_s
game.active_piece = game.grid[0][0]
p game.active_piece.location
p game.white_king
game.to_s
