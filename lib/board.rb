require 'observer'
require_relative 'displayable'

class Board
  include Displayable
  include Observable
  attr_reader :black_king, :white_king, :mode
  attr_accessor :data, :active_piece, :previous_piece
  def initialize(grid = Array.new(8) { Array.new(8) }, params = {})
    @grid = grid
    @active_piece = params[:active_piece]
    @previous_piece = params[:previous_piece]
    @black_king = params[:black_king]
    @white_king = params[:white_king]
    @mode = params[:mode]
  end

  #starting position of peices
  def initial_rows(color, row)
    @grid[row] = [
      Rook.new(self, {color: color, location: [row, 0] }),
      Knight.new(self, {color: color, location: [row, 1]}),
      Bishop.new(self, {color: color, location: [row, 2]}),
      Queen.new(self, {color: color, location: [row, 3]}),
      King.new(self, {color: color, location: [row, 4]}),
      Bishop.new(self, {color: color, location: [row, 5]}),
      Knight.new(self, {color: color, location: [row, 6]}),
      Rook.new(self, {color: color, location: [row, 7]}),
    ]
  end
  #starting position of pawns
  def initial_pawn_rows(color, row)
    8.times do |index|
      @grid[row][index] = Pawn.new(self, {color: color, location: [row, index]})
    end
  end
  #starting position of peices
  def initial_placements
    initial_rows(:black, 0)
    initial_pawn_rows(:black, 1)
    initial_pawn_rows(:white, 6)
    initial_rows(:white, 7)
    @white_king = @grid[7][4]
    @black_king = @grid[0][4]
  end

  def update_all_moves_captures
    pieces = @grid.flatten(1).compact
    pieces.each { |piece| piece.update(self) }
  end

end
