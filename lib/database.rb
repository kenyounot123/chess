#Contains logic for serialization

module Database 
  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    file_name = create_file_name
    File.open("saved_games/#{file_name}", 'w+') do |file|
      Marshal.dump(self, file)
    end
    puts "Game saved as \e[36m#{file_name}\e[0m"
    @play_counter = 0
  rescue SystemCallError => e
    puts "Error while writing to file #{file_name}"
    puts e
  end

  def load_game
    file_name = find_saved_file
    File.open("saved_games/#{file_name}") do |file|
      Marshal.load(file)
    end
  end

  def find_saved_file
    saved_games = create_game_list
    if saved_games.empty?
      puts "There are no saved games yet!"
      exit
    else
      print_saved_games(saved_games)
      file_name = select_saved_game(saved_games.size)
      saved_games[file_name.to_i - 1]
    end
  end

  def print_saved_games(saved_list)
    puts "\e[36m[#]\e[0m File Name(s)"
    saved_list.each_with_index do |game_name, index|
      puts "\e[36m[#{index + 1}]\e[0m #{game_name}"
    end
  end

  def select_saved_game(number)
    file_number = gets.chomp
    return file_number if file_number.to_i.between?(1,number)

    puts "Input Error! Enter correct file number."
    select_saved_game(number)
  end

  def create_game_list
    game_list = []
    return game_list unless Dir.exist? 'saved_games'
    Dir.entries('saved_games').each do |name|
      game_list << name if name.match(/(Chess)/)
    end
    game_list
  end

  def create_file_name
    date = Time.now.strftime("%Y-%m-%d")
    time = Time.now.strftime("%H:%M")
    "Chess file #{date} #{time}"
  end

end