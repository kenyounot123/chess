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
  end

  def switch_turn
    @current_turn = @current_turn == :white ? :black : :white
  end





  def play
    set_up_board
    puts "White goes first! Enter coordinates of the piece you want to move"
    player_turn until game_over?
  end

  def player_turn
    #Ask user to input coordinate of move, disable all black symbol moves
    #
    #update active piece to player inputed coordinates and show move options
    select_piece_coords
  

    switch_turn
  end

  #Updates board to show the selected piece
  def select_piece_coords
    @board.update_active_piece(translate_coordinates(prompt_user_selected_piece))
    show_move_options
  end
  #Checks if user input is valid when selecting piece to move
  def valid_user_input?(input)
    if input.length != 2 
      false
    else
      coords = input.split('')
      coords[0].between?('a','h') && coords[1].between?('1','8')
    end
  end

  #returns validated user input
  def prompt_user_selected_piece
    user_input_coords = gets.chomp
    until valid_user_input?(user_input_coords)
      user_input_coords = gets.chomp
    end
    user_input_coords
  end

  def show_move_options
    @board.active_piece.get_possible_moves(@board).each do |move|
      @board.active_piece.moves << move 
    end
    @board.to_s
  end





  
  def translate_coordinates(input)
    translator ||= NotationTranslator.new()
    translator.translate_notation(input)
  end

  #Game over condition should be checkmate or stalemate
  def game_over?
  end

  def set_up_board
    @board.initial_placements
    @board.to_s
  end

end

game = Game.new
game.play
