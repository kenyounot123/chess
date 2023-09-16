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

  class InputError < StandardError
    def message
      "Invalid input! Enter column and row"
    end
  end

  class CoordinateError < StandardError
    def message
      "Invalid coordinates! Enter column and row for your color"
    end
  end
  class MoveError < StandardError
    def message
      "This coordinate is not one of the piece's available move"
    end
  end
  class PieceError < StandardError
    def message
      "This piece has no available moves"
    end 
  end

  def initialize(board = Board.new, current_turn = :white)
    @board = board
    @current_turn = current_turn
  end

  def switch_turn
    @current_turn = @current_turn == :white ? :black : :white
  end

  def play
    set_up_board
    player_turn until game_over?
  end

  def player_turn
    puts "It is now #{@current_turn}'s turn"
    select_piece_coords
    move = select_move_coords
    @board.update(move)
    @board.to_s
    switch_turn
  end


  def select_piece_coords
    input = user_select_piece
    coords = translate_coordinates(input)
    validate_piece_coordinates(coords)
    @board.update_active_piece(coords)
    validate_active_piece(@board.active_piece)
    show_moves_option
  rescue StandardError => e
    puts e.message
    retry
  end

  def select_move_coords
    input = user_select_move
    coords = translate_coordinates(input)
    validate_move(coords)
    coords
  rescue StandardError => e
    puts e.message
    retry
  end

  #Checks if user input is valid when selecting piece to move
  def validate_piece_input(input)
    raise InputError unless input.match?(/^[a-h][1-8]$|^[q]$|^[s]$/i) 
  end
  #Checks if user input is valid when choosing coordinates to move to
  def validate_move_coordinates(input)
    raise InputError unless input.match?(/^[a-h][1-8]$/i)
  end
  #Checks if coordinates are viable by seeing if the color matches the current turn color
  def validate_piece_coordinates(coords)
    raise CoordinateError unless @board.valid_piece?(coords, @current_turn)
  end
  def validate_active_piece(piece)
    raise PieceError unless piece.moves.size >= 1 
  end

  #Validates user selected piece
  def user_select_piece
    input = user_input("Enter coordinate of piece you want to move, example: d3")
    validate_piece_input(input)
    input
  end
  #Validates user selected move, makes sure it is a valid input: example, d3
  def user_select_move
    input = user_input("Enter coordinate of where you want this piece to move")
    validate_move_coordinates(input)
    input
  end

  #Makes sure that the moove is part of piece's moveset
  def validate_move(coords)
    raise MoveError unless @board.valid_piece_move?(coords)
  end

  #Displays available moves for active piece
  def show_moves_option
    @board.active_piece.find_possible_moves(@board).each do |move|
      @board.active_piece.moves << move 
    end
    p @board.active_piece.moves
    @board.to_s
  end

  def user_input(prompt)
    puts prompt
    gets.chomp
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
