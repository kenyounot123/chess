require_relative 'symbols'
module Displayable
  private
  def print_chess_board
    system 'clear'
    puts "\e[32m   a b c d e f g h\e[0m"
    print_board
    puts "\e[32m   a b c d e f g h\e[0m"
  end

  def print_board
    @grid.each_with_index do |row, index|
      print "\e[32m #{8 - index} \e[0m"
      print "#{row[0]}ddddddddddddd"
      puts "\e[32m #{8 - index} \e[0m"
    end
  end

  def print_rows(row, index)
    puts "#{@grid[row][index]}"
  end


end
class Board
  include ChessSymbols
  include Displayable
  attr_accessor :grid
  def initialize()
    @grid = Array.new(8) { Array.new(8, 'hi') }
    print_chess_board
  end

end

board = Board.new


