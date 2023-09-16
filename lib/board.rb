require 'observer'
require_relative 'displayable'

class Board
  include Displayable
  include Observable
  attr_reader :black_king, :white_king, :mode
  attr_accessor :grid, :active_piece, :previous_piece
  def initialize(grid = Array.new(8) { Array.new(8) }, params = {})
    @grid = grid
    @active_piece = params[:active_piece]
    @previous_piece = params[:previous_piece]
    @black_king = params[:black_king]
    @white_king = params[:white_king]
  end

  #starting position of peices
  def initial_rows(color, row)
    @grid[row] = [
      Rook.new(self, {color: color, location: [row, 0] }),
      Knight.new(self, {color: color, location: [row, 1] }),
      Bishop.new(self, {color: color, location: [row, 2] }),
      Queen.new(self, {color: color, location: [row, 3] }),
      King.new(self, {color: color, location: [row, 4] }),
      Bishop.new(self, {color: color, location: [row, 5] }),
      Knight.new(self, {color: color, location: [row, 6] }),
      Rook.new(self, {color: color, location: [row, 7] }),
    ]
  end
  #starting position of peices
  def initial_placements
    initial_rows(:black, 0)
    initial_pawn_rows(:black, 1)
    initial_pawn_rows(:white, 6)
    initial_rows(:white, 7)
    @white_king = @grid[7][4]
    @black_king = @grid[0][4]
    update_all_moves_captures
  end
  
  def to_s
    print_chess_board
  end

  

  def valid_piece?(coord,color)
    piece = @grid[coord[:row]][coord[:column]]
    piece&.color == color 
  end
  
  #Move active piece to new location, if new location has a piece then capture it and move, if not then successfully moved.
  def update(coords)
    row = coords[:row]
    column = coords[:column]
    location = @active_piece.location
    self.delete_observer(@grid[row][column]) if @grid[row][column]
    @grid[row][column] = @active_piece
    @grid[location[0]][location[1]] = nil
    @active_piece.update_location(row, column)
    reset_board_values
  end

  def update_active_piece(coordinates)
    @active_piece = @grid[coordinates[:row]][coordinates[:column]]
  end

  #Checks that the coordinate is one of the piece's available move
  def valid_piece_move?(coord)
    coordinate_to_check = [coord[:row], coord[:column]]
    @active_piece.moves.any?(coordinate_to_check) || @active_piece.captures.any?(coordinate_to_check)
  end

  #This method is called after a piece successfully moves, resets board and notifies all of the pieces to update moves/captures
  def reset_board_values
    @previous_piece = @active_piece
    @active_piece = nil
    changed
    notify_observers(self)
  end
  private 

  #starting position of pawns
  def initial_pawn_rows(color, row)
    8.times do |index|
      @grid[row][index] = Pawn.new(self, {color: color, location: [row, index]})
    end
  end

  def update_all_moves_captures
    pieces = @grid.flatten(1).compact
    pieces.each { |piece| piece.update(self) }
  end
end
