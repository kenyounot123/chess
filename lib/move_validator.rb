#Contains logic to validate moves given a deep copy of the board by testing multiple scenarios
class MoveValidator
  include ChessSymbols
  def initialize(location, temp_board, move, piece = temp_board.grid[location[0]][location[1]])
    @board = temp_board
    @moves_list = move
    @location = location
    @current_piece = piece
    @king_location = nil
  end

  def validate_moves
    @king_location = find_king_location
    p @location
    @board.grid[@location[0]][@location[1]] = nil
    p @moves_list
    @moves_list.select do |move|
      legal_move?(move)
    end
  end

  private
  #changes piece to the possible move and checks if king is safe
  #captured_piece used to store the piece so that we can restore its state after moving the piece to check
  def legal_move?(move)
    captured_piece = @board.grid[move[0]][move[1]]
    move_current_piece(move)
    king = @king_location || move
    result = king_safe?(king)
    @board.grid[move[0]][move[1]] = captured_piece
    result
  end

  def move_current_piece(move)
    @board.grid[move[0]][move[1]] = @current_piece
    @current_piece.update_location(move[0],move[1])
  end

  def king_safe?(king_location)
    pieces = @board.grid.flatten(1).compact
    pieces.none? do |piece|
      next unless piece.color != @current_piece.color

      captures = piece.find_possible_captures(@board)
      captures.include?(king_location)
    end
  end

  def find_king_location
    return if @current_piece == king_symbol
    if @current_piece.color == :black 
      @board.black_king.location
    else
      @board.white_king.location
    end
  end



end