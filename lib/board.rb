require_relative 'symbols'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/pawn'
module Displayable
  private
  def print_chess_board
    system 'clear'
    puts "\e[32m    a  b  c  d  e  f  g  h\e[0m"
    print_board 
    puts "\e[32m    a  b  c  d  e  f  g  h\e[0m"
  end

  def print_board
    @grid.each_with_index do |row, index|
      print "\e[32m #{8 - index} \e[0m"
      print_rows(row, index)
      puts "\e[32m #{8 - index} \e[0m"
    end
  end

  def print_rows(row_array, row_index)
    row_array.each_with_index do |square, index|
      if row_index % 2 == 0 #even index  
        print white_background(square) if index % 2 == 0 #even squares are light
        print black_background(square) if index % 2 == 1 # odd squares are dark 
      elsif row_index % 2 == 1 
        print black_background(square) if index % 2 == 0 #even squares are dark
        print white_background(square) if index % 2 == 1 # odd squares are light
      end
    end
  end
  # 100 : dark grey 
  # 47 : light grey
  #if row index = odd do white square then black square
  #if row index = even do black square then white square
  def black_background(square)
    "\e[100m#{square}\e[0m"
  end

  def white_background(square)
    "\e[47m#{square}\e[0m"
  end
  
end
class Board
  include ChessSymbols
  include Displayable
  attr_accessor :grid
  #somehow make the arrays contain the correct chess piece isntead of 'h'
  #essentially, if no piece in the square, make it a empty string '     '
  def initialize(board_state = nil)
    @grid = Array.new(8) { Array.new(8, '   ') } 
    #board_starting_position
    initial_placements
    print_chess_board
  end

  def initial_rows(color, row)
    @grid[row] = [
      Rook.new([row, 0], color).symbol,
      Knight.new([row, 1], color).symbol,
      Bishop.new([row, 2], color).symbol,
      Queen.new([row, 3], color).symbol,
      King.new([row, 4], color).symbol,
      Bishop.new([row, 5], color).symbol,
      Knight.new([row, 6], color).symbol,
      Rook.new([row, 7], color).symbol
    ]
  end

  def initial_pawn_rows(color, row)
    8.times do |index|
      @grid[row][index] = Pawn.new([row, index], color).symbol
    end
  end

  def initial_placements
    initial_rows('black', 0)
    initial_pawn_rows('black', 1)
    initial_pawn_rows('white', 6)
    initial_rows('white', 7)
  end

end

board = Board.new
