require_relative 'pieces'
class Knight < Pieces
  include ChessSymbols
  def initialize(board, args)
    super(board, args)
    @symbol = knight_symbol
  end

  # def all_possible_moves(start = @location, result=[]) 
  #   @move_set.each do |move|
  #     rank = start[0] + move[0]
  #     file = start[1] + move[1]
  #     result << [rank,file] if rank.between?(0,7) && file.between?(0,7)
  #   end
  #   result
  # end

end