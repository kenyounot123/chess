require_relative 'symbols'
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
        print white_background(square) if index % 2 == 0 #even squares are white
        print black_background(square) if index % 2 == 1 # odd squares are black
      elsif row_index % 2 == 1 
        print black_background(square) if index % 2 == 0 #even squares are black
        print white_background(square) if index % 2 == 1 # odd squares are white
      end
    end
  end
  # 100 : dark grey 
  # 47 : light grey
  # 30; : black font
  # 39; white font
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
  def initialize(board_state = nil)
    @grid = Array.new(8) { Array.new(8, white_king) } 
    #board_starting_position
    print_chess_board
  end

end

board = Board.new
