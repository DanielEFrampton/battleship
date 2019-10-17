class Game
  attr_reader :player_board, :computer_board, :possible_ships
  attr_accessor :computer_hunting, :most_recent_hit
  
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @possible_ships = [["Cruiser", 3],["Submarine", 2]]
    @computer_hunting = false
    @most_recent_hit = nil
  end

  def game_over?
    [@player_board, @computer_board].any? {|board| board.all_ships_sunk?}
  end

  def winner
    if @computer_board.all_ships_sunk?
      "You won!"
    elsif @player_board.all_ships_sunk?
      "I won! You suck!"
    end
  end

  def create_ships
    @possible_ships.map do |ship_name, ship_length|
      Ship.new(ship_name, ship_length)
    end
  end
end
