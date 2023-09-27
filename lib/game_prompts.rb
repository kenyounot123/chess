#Module for all game prompts and messages
module GamePrompts
  def select_game_mode
    mode = gets.chomp
    return mode if mode.match?(/^[12]$/)

    puts "Input error, please enter 1 or 2"
    select_game_mode
  end

  def king_check_warning
    "WARNING!!!! Your king is currently in check!"
  end

  def game_over_message
    return unless @play_counter.positive?
    if @board.king_in_check?(@current_turn)
      puts "#{@previous_color} wins! #{current_turn} king is in checkmate"
    else
      puts "#{@previous_color} wins in a stalemate!"
    end
  end

  #Error-handling for player input when asked to play again
  def repeat_game
    puts play_again_message
    input = gets.chomp
    choice = input.upcase == 'Q' ? :quit : :repeat
    return choice if input.match?(/^[QP]$/i)
    repeat_game
  end
  def user_piece_selection
    <<~HEREDOC

    Enter coordinates of piece you want to move, example: d3
    [Q] to QUIT or [S] to SAVE

    HEREDOC
  end

  def user_move_selection
    <<~HEREDOC

    Enter coordinates of legal move or capture for this piece
    

    HEREDOC
  end
  def en_passant_warning
    <<~HEREDOC

    One of these moves is to capture the opposing pawn that just moved.

    As part of en passant, this pawn will move to the square in front of the captured pawn. 

    HEREDOC
  end

  def castle_warning
    <<~HEREDOC

    One of these moves will castle with the rook

    HEREDOC
  end

  def play_again_message
    <<~HEREDOC

    Would you like to QUIT or PLAY AGAIN?
    [Q] to QUIT or [P] to PLAY AGAIN
    
    HEREDOC
  end

  def start_game_choices
    <<~HEREDOC

      \e[36mWelcome to Chess!\e[0m

      Each turn will be played in two different steps.

      \e[36mStep One:\e[0m
      Enter the coordinates of the piece you want to move.

      \e[36mStep Two:\e[0m
      Enter the coordinates of any legal move or capture\e[0m.


      To begin, enter one of the following to play:
        \e[36m[1]\e[0m to play a \e[36mnew 2-player\e[0m game
        \e[36m[2]\e[0m to play a \e[36msaved\e[0m game
    HEREDOC
  end


  def previous_color
    @current_turn == :white ? 'Black' : 'White'
  end

  def resign_game
    puts "\e[36m#{previous_color}\e[0m wins because #{@current_turn} resigned!"
    @play_counter = 0
  end


end