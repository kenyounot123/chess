#Contains script to play the chess game
require_relative 'game_prompts'
require_relative 'database'
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

  include GamePrompts
  include Database

  def initialize(board = Board.new, current_turn = :white)
    @board = board
    @current_turn = current_turn
  end

  def switch_turn
    @current_turn = @current_turn == :white ? :black : :white
  end

  def play
    @board.to_s
    player_turn until @board.game_over?
    game_over_message
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
    return if input == "Q"
    coords = translate_coordinates(input)
    validate_piece_coordinates(coords)
    @board.update_active_piece(coords)
    validate_active_piece(@board.active_piece)
    @board.to_s
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
  #Checks if piece has availalbe moves
  def validate_active_piece(piece)
    raise PieceError unless piece.moves.size >= 1 || piece.captures.size >= 1
  end
  #Makes sure that the move is part of piece's moveset
  def validate_move(coords)
    raise MoveError unless @board.valid_piece_move?(coords)
  end

  #Validates user selected piece
  def user_select_piece
    king_check_warning if @board.king_in_check?(@current_turn)
    input = user_input(user_piece_selection)
    validate_piece_input(input)
    if input.upcase == 'Q'
      resign_game 
      exit
    end
    save_game if input.upcase == 'S'
    input
  end
  #Validates user selected move, makes sure it is a valid input: example, d3
  def user_select_move
    input = user_input(user_move_selection)
    validate_move_coordinates(input)
    input
  end


  def user_input(prompt)
    puts prompt
    gets.chomp
  end

  
  def translate_coordinates(input)
    translator ||= NotationTranslator.new()
    translator.translate_notation(input)
  end

  

  def set_up_board
    @board.initial_placements
  end

end

