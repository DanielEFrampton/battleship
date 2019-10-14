class Game
  attr_reader :player_board, :computer_board, :possible_ships, :last_turn
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @possible_ships = {cruiser: Ship.new("Cruiser", 3),
                      submarine: Ship.new("Submarine", 2)}
    @last_turn = {computer_shot: nil,
                  computer_result: nil,
                  player_shot: nil,
                  player_result: nil}
  end
end
