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
    assert_instance_of Hash, @game_1.possible_ships
    assert_equal [:cruiser, :submarine], @game_1.possible_ships.keys
    assert_equal true, @game_1.possible_ships.values.all? {|value| value.class == Ship}
    assert_equal "Cruiser", @game_1.possible_ships[:cruiser].name
    assert_equal "Submarine", @game_1.possible_ships[:submarine].name
    assert_equal 3, @game_1.possible_ships[:cruiser].length
    assert_equal 2, @game_1.possible_ships[:submarine].length
    assert_equal [:computer_shot, :computer_result, :player_shot, :player_result], @game_1.last_turn.keys
    assert_nil @game_1.last_turn.values.all? {|value| value == nil}
  end


end
