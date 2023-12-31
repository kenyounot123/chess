require_relative 'pieces'
class Knight < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = knight_symbol
  end

  #returns a list of possible moves
  def find_possible_moves(board)
    possibilities = []
    move_set.each do |move|
      rank = @location[0] + move[0]
      file = @location[1] + move[1]
      possibilities << [rank,file] if valid_location?(rank,file) && board.grid[rank][file].nil?
    end
    possibilities
  end

  #returns a list of possible captures
  def find_possible_captures(board)
    possibilities = []
    move_set.each do |move|
      rank = @location[0] + move[0]
      file = @location[1] + move[1]
      possibilities << [rank,file] if opposing_piece?(board.grid, rank, file)
    end
    possibilities
  end

  private

  def move_set
   [[1,2], [-1,2], [-1,-2], [1,-2], [-2,1], [2,1], [2,-1], [-2,-1]] 
  end

end