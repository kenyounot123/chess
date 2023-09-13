# first focus on creating the chess board and chess pieces to appear on terminal
require_relative 'board'

class Game
  def initialize()
    @board = Board.new
  end

  def select_piece(file,rank)
    all_files= {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }
    rank = (rank - 8).abs
    puts @board.grid[rank][all_files[file]]
  end
  
end

game = Game.new
game.select_piece('e',8)