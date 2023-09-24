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
  end

  def remove_capture_piece
    @board.delete_observer(@board.grid[row][column])
  end


end