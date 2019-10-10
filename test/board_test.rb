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

    # Confirms the class of every key is String, and every value is Cell
    assert_equal true, @board.cells.keys.all? {|key| key.class == String}
    assert_equal true, @board.cells.values.all? {|value| value.class == Cell}
    
    # Confirms each key has a length of 2
    assert_equal 2, @board.cells.keys.sample.length
  end

  def test_it_can_identify_a_valid_coordinate
    # Confirms returns true if coordinate exists as a key in hash of cells
    assert_equal true, @board.valid_coordinate?("A4")
    assert_equal true, @board.valid_coordinate?("B2")

    # Confirms returns false if it doesn't
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?("D5")
  end

  def test_it_can_check_valid_placement_of_ship
    # Confirms return value is false if length of placement is different than length of ship
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"]) # Too short
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2"]) # Too short

    # Confirms return value is false if placement cells are non-consecutive

  end

  def
end
