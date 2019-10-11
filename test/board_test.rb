require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_starts_with_hash_of_cells

    # Confirms .cells returns a Hash object
    assert_instance_of Hash, @board.cells

    # Confirms Hash has 16 key-value pairs
    assert_equal 16, @board.cells.size

    # Confirms the class of every value is Cell
    assert_equal true, @board.cells.values.all? {|value| value.class == Cell}
  end

  def test_it_has_hash_of_coordinate_string_keys
    # Confirms the class of every key is String
    assert_equal true, @board.cells.keys.all? {|key| key.class == String}

    # Confirms each key has a length of 2
    assert_equal true, @board.cells.keys.all? {|key| key.length == 2}

    # Confirms each key is made up of A-D and 1-4; consider moving code to class itself
    possible_combinations = ("A".."D").reduce([]) do |coord_array, letter|
      coord_array += (1..4).map { |number| "#{letter}#{number}" }
    end
    assert_equal true, @board.cells.keys.all? {|key| possible_combinations.include?(key)}

    # Add check to confirm coordinate of cell is same as key
    assert_equal true, @board.cells.all? {|key, cell| cell.coordinate == key}
  end

  def test_it_can_identify_a_valid_coordinate
    skip
    # Confirms returns true if coordinate exists as a key in hash of cells
    assert_equal true, @board.valid_coordinate?("A4")
    assert_equal true, @board.valid_coordinate?("B2")

    # Confirms returns false if it doesn't
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?("D5")
  end

  def test_it_denies_valid_placement_when_length_of_cells_is_wrong
    skip
    # Confirms return value is false if number of cells is different than length of ship
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"]) # Too short
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2"]) # Too short
  end

  def test_it_denies_valid_placement_when_cells_are_not_consecutive_or_misordered
    skip
    # Confirms return value is false if placement cells are non-consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"]) # Missing A3
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"]) # Missing B1
  end

  def test_it_denies_valid_placement_when_cells_are_not_left_to_right_or_top_to_bottom
    skip
    # Confirms return value is false if cells are not in left-to-right or top-to-bottom order
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"]) # Right-to-left
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"]) # Bottom-to-top
  end

  def test_it_denies_valid_placement_when_cells_are_diagonal
    skip
    # Confirms return value is false if placement cells are diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  # Test .place
  def test_it_can_place_same_ship_in_multiple_cells
    skip
    # Testing on first ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @board.cells["A1"].ship
    assert_equal @cruiser, @board.cells["A2"].ship
    assert_equal @cruiser, @board.cells["A3"].ship
    assert_same @board.cells["A1"].ship, @board.cells["A2"].ship

    # Testing on second ship in different location
    @board.place(@submarine, ["C4," "D4"])
    assert_equal @submarine, @board.cells["C4"].ship
    assert_equal @submarine, @board.cells["D4"].ship
    assert_same @board.cells["C4"].ship, @board.cells["D4"].ship
  end

  # Test that .place does not allow overlapping ships
  def test_it_denies_valid_placement_if_ship_is_in_any_cells
    skip
    # Testing first ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1," "B1"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2," "B2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A3," "B3"])
  end

  # Test .render method
  def test_it_can_render_initial_board_state
    skip
    # Testing what board should render as after ships placed, but before any player turns occur
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C4," "D4"])
    beginning_board_render = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal beginning_board_render, @board.render

    # Testing what board should render as with "true" optional parameter, showing ships
    ship_placed_board_render = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . S \nD . . . S \n"
    assert_equal ship_placed_board_render, @board.render(true)
  end

  # Add tests later for board state after cells have been fired upon, ships sunk, etc.

end
