require_relative '../board'

class Pieces 
  attr_reader :color, :location, :symbol, :moves, :captures, :moved
  def initialize(board, args)
    board.add_observer(self)
    @color = args[:color]
    @location = args[:location]
    @moves = []
    @captures = []
    @moved = false
    @symbol = nil
  end

  #THIS NEEDS TO BE CHANGED, IT IS CURRENTLY PLACEHOLDER
  # method used when notified of a change in Board (as an observer)
  def update(board)
    update_new_moves(board)

  end

  def valid_location?(row, column)
    row.between?(0,7) && column.between?(0,7)
  end

  def update_location(row, column)
    @location = [row, column]
    @moved = true
  end

  def update_new_moves(board)
    possible_moves = find_possible_moves(board)
    @moves = possible_moves
  end
  def find_possible_moves(board,result=[])
    move_set.each do |move|
      result << create_moves(board.grid, move[0], move[1])
    end
    result.compact.flatten(1)
  end

  # #Add serialization in this method
  # def remove_illegal_moves(board, moves)
  #   return moves unless moves.size > 0 
    
  # end

  private
  

  #Creates a set of all moves 
  def create_moves(grid, rank_change, file_change)
    all_possibile_moves = []
    rank = @location[0] + rank_change
    file = @location[1] + file_change
    while valid_location?(rank, file)
      break if grid[rank][file]
      all_possibile_moves << [rank, file]
      rank += rank_change
      file += file_change
    end
    all_possibile_moves
  end
end

