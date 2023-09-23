
#logic to translate player input of letter(column) and number(row) to our coordinate row and column
class NotationTranslator 

  def initialize()
    @row = nil
    @column = nil
  end

  #returns a hash with correct row and column coordinates
  def translate_notation(player_input)
    input = player_input.split('')
    letter = input[0]
    number = input[1]
    translate_column(letter)
    translate_row(number)
    { row: @row, column: @column }
  end
  
  #converts user input of column letter(a-h) to a number (0 - 7)
  def translate_column(letter)
    all_columns = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7,
    }
    @column = all_columns[letter]
  end

  #converts user input of row number (8-1) to a number (0-7)
  def translate_row(number)
    @row = (8 - number.to_i).abs
  end

end

#testing
# translate = NotationTranslator.new
# p translate.translate_notation('a5')
