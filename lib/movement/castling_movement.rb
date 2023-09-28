require_relative 'basic_movement'

class CastleMovement < BasicMovement
  def initialize(board = nil, row = nil, column = nil)
    super
  end

  def update_pieces(board, coords)
    @board = board
    @row = coords[:row]
    @column = coords[:column]
    update_castle_moves
  end

  def update_castle_moves
    update_new_coordinates
    remove_original_piece
    update_active_piece_location
    castling_rook = find_castling_rook
    remove_original_rook_piece
    update_castling_coordinates(castling_rook)
    update_new_rook_location(castling_rook)
  end

  def find_castling_rook
    @board.grid[row][old_rook_column]
  end

  def remove_original_rook_piece
    @board.grid[row][old_rook_column] = nil
  end

  def update_castling_coordinates(rook)
    @board.grid[row][new_rook_column] = rook
  end

  def update_new_rook_location(rook)
    rook.update_location(row, new_rook_column)
  end


  private

  def old_rook_column
    king_side = 7
    queen_side = 0
    column == 2 ? queen_side : king_side
  end

  def new_rook_column
    king_side = 5
    queen_side = 3
    column == 2 ? queen_side : king_side
  end
end
