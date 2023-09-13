#Class for symbols 
  # 30; : black font
  # 39; white font
module ChessSymbols 
  def white_king
    "\e[39m \u265A \e[0m"
  end
  def white_queen
    "\e[39m \u265B \e[0m"
  end
  def white_rook
    "\e[39m \u265C \e[0m"
  end
  def white_bishop 
    "\e[39m \u265D \e[0m"
  end
  def white_knight
    "\e[39m \u265E \e[0m"
  end
  def white_pawn
    "\e[39m \u265F \e[0m"
  end
  def black_king
    "\e[30m \u265A \e[0m"
  end
  def black_queen
    "\e[30m \u265B \e[0m"
  end
  def black_rook
    "\e[30m \u265C \e[0m"
  end
  def black_bishop 
    "\e[30m \u265D \e[0m"
  end
  def black_knight
    "\e[30m \u265E \e[0m"
  end
  def black_pawn
    "\e[30m \u265F \e[0m"
  end
  
end