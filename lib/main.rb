require_relative 'board'
require_relative 'displayable'
require_relative 'chess_symbols'
require_relative 'chess_pieces/pieces'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/pawn'
require_relative 'notation_translator'
require_relative 'database'
require_relative 'movement/movement_factory'
require_relative 'movement/basic_movement'
require_relative 'movement/pawn_promotion_movement'
require_relative 'movement/en_passant_movement'
require_relative 'movement/castling_movement'
require_relative 'game_prompts'
require_relative 'game'

extend GamePrompts
extend Database


def play_game(input)
  if input == '1'
    two_players = Game.new
    two_players.set_up_board
    two_players.play
  elsif input == '2'
    load_game.play
  end
end


loop do 
  puts start_game_choices
  mode = select_game_mode
  play_game(mode)
  break if repeat_game == :quit
end
