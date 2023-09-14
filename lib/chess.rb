# first focus on creating the chess board and chess pieces to appear on terminal
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

game = Board.new
game.initial_placements
game.print_chess_board