require_relative 'pieces'
class Pawn < Pieces
  include ChessSymbols
  attr_reader :en_passant
  def initialize(board, args)
    super(board, args)
    @symbol = pawn_symbol
    @en_passant = false
    @moved = false
  end

  def rank_direction 
    color == :white ? -1 : 1 
  end
  
  def find_possible_moves(board)
    [one_square_move(board), two_square_move(board)].compact
  end

  def update_location(row, column)
    update_en_passant(row)
    @location = [row, column]
    @moved = true
  end

  #Returns Pawn @en_passant to be true if it moved two spaces in one move
  def update_en_passant(row)
    @en_passant = (row - location[0]).abs == 2
  end

  def find_possible_captures(board)
    possible_captures = []
    file = @location[1]
    right_diagonal = basic_capture_move(board.grid, file + 1)
    left_diagonal = basic_capture_move(board.grid, file - 1)
    possible_captures << right_diagonal << left_diagonal << en_passant_capture(board)
    possible_captures.compact
  end

  def en_passant_rank?
    rank = location[0]
    (rank == 4 && color == :black) || (rank == 3 && color == :white)
  end
  private 

  def one_square_move(board)
    move = [@location[0] + rank_direction, @location[1]]
    return move unless board.grid[move[0]][move[1]]
  end
  def two_square_move(board)
    move = [@location[0] + (2 * rank_direction), @location[1]]
    return move unless not_first_move?(board, move)
  end

  #Diagonal movement for pawn captures
  def basic_capture_move(board, file)
    rank = @location[0] + rank_direction
    return [rank, file] if opposing_piece?(board,rank,file)
  end

  #returns the location of the capture piece by en passant
  def en_passant_capture(board)
    capture = board.previous_piece&.location 
    return unless capture

    column_difference = (location[1] - capture[1]).abs
    return unless column_difference == 1

    return capture if valid_en_passant?(board)
  end

  #Checks if pawn is able to enpssant
  def valid_en_passant?(board)
    en_passant_rank? &&
      symbol == board.previous_piece.symbol &&
      board.previous_piece.en_passant &&
      legal_en_passant_move?(board) 
  end

  #Checks if the en_passant will not leave the King in check
  def legal_en_passant_move?(board) 
    pawn_location = board.previous_piece.location
    en_passant_move = [pawn_location[0], pawn_location[1] + rank_direction]
    temp_board = remove_captured_en_passant_pawn(board, pawn_location)
    legal_capture = remove_illegal_moves(en_passant_move, temp_board)
    legal_capture.size >= 0
  end

  #Creates a copy of the board where the captured pawn location is empty
  def remove_captured_en_passant_pawn(board, pawn_location)
    temp_board = Marshal.load(Marshal.dump(board))
    temp_board.grid[pawn_location[0]][pawn_location[1]] = nil
    temp_board
  end


  #Returns true if it is the pawn's first move 
  def not_first_move?(board,move)
    @moved || board.grid[move[0]][move[1]]
  end


  def move_set ;end
end