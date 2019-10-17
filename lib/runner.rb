class Runner
  attr_reader :game

  def initialize
    @game = nil
  end

  def main_menu
    system("clear")
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter p to play#{" again" if @game != nil}. Enter q to quit."
      user_input = gets.chomp
      if user_input == 'p'
        setup # proceed to next step of game
        game_turns # after setup proceed to main game
        end_game
      elsif user_input == 'q'
        break # ends the main_menu method, closing the Ruby file
      end
    end
  end

  def setup
    @game = Game.new
    # place computer ships
    @game.create_ships.each do |ship_object|
      @game.computer_board.place_ship_randomly(ship_object)
    end

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long, and the Submarine is two units long."

    # loop to prompt user to place all ships
    @game.create_ships.each do |ship_object|
      until @game.player_board.all_ships.include?(ship_object)
        puts @game.player_board.render(true)
        puts "Enter the coordinates for the #{ship_object.name}:"
        user_input = gets.chomp.upcase.split(' ')
        if @game.player_board.valid_placement?(ship_object, user_input)
          @game.player_board.place(ship_object, user_input)
        else
          puts "Those coordinates were invalid. Use the format: A1 A2#{" A3" if ship_object.name == 'Cruiser'}"
        end
      end
    end
  end
  # after designing game turns revisit whether to render the board one more time

  def game_turns
    system("clear")
    until @game.game_over?
      # render both boards
      puts "COMPUTER BOARD".center(40, "=") # change this to make it dynamic according to board size
      puts @game.computer_board.render
      puts "PLAYER BOARD".center(40, "=")
      puts @game.player_board.render(true)
      # instruct player to enter coordinate to shoot
      puts "Enter the coordinate for your shot:"
      # get user input
      user_input = nil
      loop do
        user_input = gets.chomp.upcase
        if @game.computer_board.valid_coordinate?(user_input) && !@game.computer_board.cell_fired_upon?(user_input)
          @game.computer_board.fire_upon_cell(user_input)
          break
        elsif @game.computer_board.valid_coordinate?(user_input) && @game.computer_board.cell_fired_upon?(user_input)
          puts "You already fired upon that coordinate. Please try again:"
        else
          puts "That was not a valid coordinate. Use the syntax: A1"
        end
      end
      # computer randomly fires at player board
      if @game.computer_hunting == true
          # randomly select an adjacent coord to previous hit
          chosen_adjacent_shot = @game.player_board.adjacent_coords(@game.most_recent_hit).sample
          @game.player_board.fire_upon_cell(chosen_adjacent_shot)
          @game.player_board.previous_computer_shot = chosen_adjacent_shot
      else
        @game.player_board.fire_upon_random_cell
      end
      # computer checks result of shot to see if it should be hunting nearby
      if @game.player_board.cells[@game.player_board.previous_computer_shot].render == "H"
        @game.computer_hunting = true
        @game.most_recent_hit = @game.player_board.previous_computer_shot
      elsif @game.player_board.cells[@game.player_board.previous_computer_shot].render == "X"
        @game.computer_hunting = false
      end
      # display results of both players' shots
      puts "Your shot on #{user_input} #{@game.computer_board.shot_result(user_input)}."
      puts "My shot on #{@game.player_board.previous_computer_shot} #{@game.player_board.shot_result(@game.player_board.previous_computer_shot)}."
    end
  end

  def end_game
    puts @game.winner
  end
end
