#Contains script to play the chess game
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

class Game

  def initialize(board = Board.new, current_turn = :white)
    @board = board
    @current_turn = current_turn
    #this is for testing
    @turn = 1
  end

  def switch_turn
    @current_turn = @current_turn == :white ? :black : :white
    @turn += 1
  end

  #pseudocode for now 
  def play
    set_up_board
    puts "White goes first! Enter coordinates of the piece you want to move"
    player_turn until game_over?
  end

  def player_turn
    #Ask user to input coordinate of move, disable all black symbol moves
    #
    #update active piece to player inputed coordinates and show move options
    user_input_coords = gets.chomp
    @board.update_active_piece(translate_coordinates(user_input_coords))
    @board.to_s
    p @board.active_piece.get_possible_moves(@board)
    p @board.grid[6][4]
    switch_turn
  end
  
  def translate_coordinates(input)
    translator ||= NotationTranslator.new()
    translator.translate_notation(input)
  end

  #Game over condition should be checkmate or stalemate
  def game_over?
    @turn == 10
  end

  def set_up_board
    @board.initial_placements
    @board.to_s
  end

end

game = Game.new
game.play
