require './test/test_helper.rb'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @game_1 = Game.new
    @game_2 = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game_1
  end

  def test_it_initializes_with_boards
    assert_instance_of Board, @game_1.player_board
    assert_instance_of Board, @game_1.computer_board
  end

  def test_it_initializes_with_changeable_computer_hunting_status
    assert_equal false, @game_1.computer_hunting
    @game_1.computer_hunting = true
    assert_equal true, @game_1.computer_hunting
  end

  def test_it_tracks_most_recent_hit_and_can_change_it
    assert_nil @game_1.most_recent_hit
    @game_1.most_recent_hit = "A1"
    assert_equal "A1", @game_1.most_recent_hit
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

  def test_it_generates_winner_message
    @game_1.computer_board.place(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @game_1.computer_board.place(Ship.new("Submarine", 2), ["B1", "B2"])
    @game_1.player_board.place(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @game_1.player_board.place(Ship.new("Submarine", 2), ["B1", "B2"])
    @game_1.player_board.fire_upon_cell("A1")
    @game_1.player_board.fire_upon_cell("A2")
    @game_1.player_board.fire_upon_cell("A3")
    @game_1.player_board.fire_upon_cell("B1")
    @game_1.player_board.fire_upon_cell("B2")
    assert_equal "I won! You suck!", @game_1.winner

    @game_2.player_board.place(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @game_2.player_board.place(Ship.new("Submarine", 2), ["B1", "B2"])
    @game_2.computer_board.place(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @game_2.computer_board.place(Ship.new("Submarine", 2), ["B1", "B2"])
    @game_2.computer_board.fire_upon_cell("A1")
    @game_2.computer_board.fire_upon_cell("A2")
    @game_2.computer_board.fire_upon_cell("A3")
    @game_2.computer_board.fire_upon_cell("B1")
    @game_2.computer_board.fire_upon_cell("B2")
    assert_equal "You won!", @game_2.winner
  end

  def test_it_can_create_ships_from_template
    assert_equal 2, @game_1.create_ships.length
    assert_equal "Cruiser", @game_1.create_ships[0].name
    assert_equal 3, @game_1.create_ships[0].length
    assert_equal "Submarine", @game_1.create_ships[1].name
    assert_equal 2, @game_1.create_ships[1].length
  end
end
