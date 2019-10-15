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
    # loop to prompt user to place all ships
      # a message that computer is done placing ships
      # explanation of how to place ships
      # visual representation of the board
      # and instruction to enter coordinates for the first ship
      # get user input
      # convert to coordinates
      # if placement is valid place ship
      # if not repeat instruction
      # prompt again
    # proceed to main turn phase
  end

  # def convert_to_array(input)
  #   input.split(' ')
  # end
end

runner = Runner.new
runner.main_menu
