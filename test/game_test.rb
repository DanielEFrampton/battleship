require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @game_1 = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game_1
  end

  def test_it_initializes
    assert_instance_of Board, @game_1.player_board
    assert_instance_of Board, @game_1.computer_board
  end

  def test_it_has_template_of_possible_ships
    expected_array = [["Cruiser", 3], ["Submarine", 2]]

    assert_equal expected_array, @game_1.possible_ships
  end

  def test_it_can_check_if_game_is_over
    @game_1.player_board.place(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @game_1.player_board.place(Ship.new("Submarine", 2), ["B1", "B2"])
    @game_1.player_board.cells["A1"].fire_upon
    @game_1.player_board.cells["A2"].fire_upon
    @game_1.player_board.cells["A3"].fire_upon
    @game_1.player_board.cells["B1"].fire_upon
    @game_1.player_board.cells["B2"].fire_upon

    assert_equal true, @game_1.game_over?
  end

end
