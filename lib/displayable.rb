

module Displayable
  
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

  #creates each row to be printed with different background
  def print_rows(row_array, row_index)
    row_array.each_with_index do |square, index|
      background_color = select_background(row_index, index)
      print_square(row_index, index, square, background_color)
    end
  end
  # 100 : dark grey backgrounds
  # 47 : light grey backgrounds
  # 106 : active piece to move background
  # 41 = red background (captures)
  # 46 = cyan background (previous piece that moved)
  #if row index = odd do white square then black square
  #if row index = even do black square then white square

  #decides background color based on certain conditions
  def select_background(row_index, column_index)
    if @active_piece&.location == [row_index, column_index]
      106
    elsif capture_background?(row_index, column_index)
      41
    elsif @previous_piece&.location == [row_index, column_index]
      46
    elsif (row_index + column_index).even?
      100
    else
      47
    end
  end


  def capture_background?(row, column)
    @active_piece&.captures&.any?([row, column]) && @grid[row, column]
  end

  # 97 = white font color for chess pieces
  # 30 = black font color for chess pieces
  # 41 = red font color for possible moves
  # 90 = dark grey font color
  #determines font color based on certain conditions
  def print_square(row_index, column_index, square, background)
    if square
      text_color = square.color == :white ? 97 : 30
      finish_square(text_color, background, square.symbol)
    elsif @active_piece&.moves&.any?([row_index, column_index])
      finish_square(41, background, " \u25CF ")
    else
      finish_square(90, background, '   ')
    end
  end

  #prints final square appearance with font, background, and string(symbol)
  def finish_square(font, background, string)
    print "\e[#{font};#{background}m#{string}\e[0m"
  end
end