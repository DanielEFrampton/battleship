class Runner
  attr_reader :game

  def initialize
    @game = nil
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter p to play. Enter q to quit."
      user_input = gets.chomp
      if user_input == 'p'
        setup # proceed to next step of game
      elsif user_input == 'q'
        break # ends the main_menu method, closing the Ruby file
      end
    end
  end

  def setup
  end

  # def convert_to_array(input)
  #   input.split(' ')
  # end
end

runner = Runner.new
runner.main_menu
