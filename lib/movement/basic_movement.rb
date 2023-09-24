class BasicMovement
  attr_reader :row, :column, :board
  def initialize(board = nil, row = nil, column = nil)
    @board = board
    @row = row
    @column = column
  end

  def update_pieces(board, coords)
    @board = board
    @row = coords[:row]
    @column = coords[:column]
    update_basic_moves
  end

  def update_basic_moves
    remove_capture_piece if @board.grid[row][column]
    update_new_coordinates
    remove_original_piece
    update_active_piece_location
  end

  def update_new_coordinates
    @board.grid[row][column] = @board.active_piece
  end

  def remove_original_piece
    location = @board.active_piece.location
    @board.grid[location[0]][location[1]] = nil
  end

  def remove_capture_piece
    @board.delete_observer(@board.grid[row][column])
  end

  def update_active_piece_location
    @board.active_piece.update_location(row, column)
  end


end