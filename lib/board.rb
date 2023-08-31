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
        print square if index % 2 == 0 #even squares are white
        print square if index % 2 == 1 # odd squares are black
      elsif row_index % 2 == 1 
        print square if index % 2 == 0 #even squares are black
        print square if index % 2 == 1 # odd squares are white
      end
    end
  end
  #if row index = odd do white square then black square
  #if row index = even do black square then white square


end
class Board
  include ChessSymbols
  include Displayable
  attr_accessor :grid
  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    print_chess_board
  end

end

board = Board.new


