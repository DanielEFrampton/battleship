require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class Runner
  attr_reader :game

  def initialize
    @game = nil
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter p to play#{" again" if @game != nil}. Enter q to quit."
      user_input = gets.chomp
      if user_input == 'p'
        setup # proceed to next step of game
        game_turns # after setup proceed to main game
      elsif user_input == 'q'
        break # ends the main_menu method, closing the Ruby file
      end
    end
  end

  def setup
    @game = Game.new
    # place computer ships
    @game.possible_ships.each do |ship_name, ship_object|
      @game.computer_board.place_ship_randomly(ship_object)
    end

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long, and the Submarine is two units long."

    # loop to prompt user to place all ships
    @game.possible_ships.each do |ship_name, ship_object|
      until @game.player_board.cells.values.any? {|cell| cell.ship == ship_object}
        puts @game.player_board.render(true)
        puts "Enter the coordinates for the #{@game.possible_ships[ship_name].name}:"
        user_input = gets.chomp.upcase.split(' ')
        if @game.player_board.valid_placement?(ship_object, user_input)
          @game.player_board.place(ship_object, user_input)
        else
          puts "Those coordinates were invalid. Use the format: A1 A2#{" A3" if ship_name == :cruiser}"
        end
      end
    end
  end
  # after designing game turns revisit whether to render the board one more time

  def game_turns
    # until @game.game_over?
    # end
  end
end

runner = Runner.new
runner.main_menu
