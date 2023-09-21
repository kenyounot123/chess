require_relative 'pieces'
class Pawn < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = pawn_symbol
  end

  def rank_direction 
    color == :white ? -1 : 1 
  end
  
  def find_possible_moves(board)
    [one_square_move(board), two_square_move(board)].compact
  end

  def find_possible_captures(board)
    possible_captures = []
    file = @location[1]
    right_diagonal = basic_capture_move(board.grid, file + 1)
    left_diagonal = basic_capture_move(board.grid, file - 1)
    possible_captures << right_diagonal << left_diagonal
    possible_captures.compact.flatten(1)
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

  #Returns true if it is the pawn's first move 
  def not_first_move?(board,move)
    @moved || board.grid[move[0]][move[1]]
  end


  def move_set
  end
end