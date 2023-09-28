require_relative 'pieces'

class King < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = king_symbol
  end

  def find_possible_moves(board)
    possibilities = []
    move_set.each do |move|
      rank = @location[0] + move[0]
      file = @location[1] + move[1]
      possibilities << [rank,file] if valid_location?(rank,file) && board.grid[rank][file].nil?
    end
    possibilities += castling_moves(board)
    possibilities.compact
  end

  def find_possible_captures(board)
    captures = []
    move_set.each do |move|
      rank = @location[0] + move[0]
      file = @location[1] + move[1]
      captures << [rank,file] if opposing_piece?(board.grid, rank, file)
    end
    captures.compact
  end

  def castling_moves(board)
    castle_moves = []
    rank = location[0]
    castle_moves << [rank, 2] if queen_side_castling?(board)
    castle_moves << [rank, 6] if king_side_castling?(board)
    castle_moves
  end
  
  #Checks king side to see if all conditions for castling are met
  def king_side_castling?(board)
    king_side_pass = 5
    king_side_rook = 7
    empty_files = [6]
    unmoved_king_rook?(board, king_side_rook) &&
      king_pass_through_safe?(board, king_side_pass) &&
      !board.king_in_check?(@color) &&
      empty_files?(board, empty_files)
  end
  #Checks queen side to see if all conditions for castling are met
  def queen_side_castling?(board)
    queen_side_pass = 3
    queen_side_rook = 0
    empty_files = [1,2]
    unmoved_king_rook?(board, queen_side_rook) &&
      king_pass_through_safe?(board, queen_side_pass) &&
      !board.king_in_check?(@color) &&
      empty_files?(board, empty_files)
  end

  def king_pass_through_safe?(board, file)
    rank = location[0]
    board.grid[rank][file].nil? && safe_passage?(board, [rank,file])
  end

  #Returns true if other pieces do not put king in check at specific location
  def safe_passage?(board, location)
    pieces = board.grid.flatten(1).compact
    pieces.none? do |piece|
      next unless piece.color != color && piece.symbol != symbol

      moves = piece.find_possible_moves(board)
      moves&.include?(location)
    end
  end

  def unmoved_king_rook?(board, file)
    piece = board.grid[location[0]][file]
    return false unless piece

    moved == false && piece.symbol == rook_symbol && piece.moved == false
  end

  def empty_files?(board, files)
    files.none? { |file| board.grid[location[0]][file] }
  end
  private
  def move_set 
    [[1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,1], [-1,-1]] 
  end
end
