class Game
  attr_reader :player_board, :computer_board, :possible_ships, :last_turn
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @possible_ships = [["Cruiser", 3],["Submarine", 2]]
    @last_turn = {computer_shot: nil,
                  computer_result: nil,
                  player_shot: nil,
                  player_result: nil}
  end

  def game_over?
    [@player_board, @computer_board].any? {|board| board.all_ships_sunk?}
  end

  def create_ships
    @possible_ships.map do |ship_name, ship_length|
      Ship.new(ship_name, ship_length)
    end
  end
end
