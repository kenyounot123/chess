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
  
  private
  def move_set 
    [[1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,1], [-1,-1]] 
  end
end
