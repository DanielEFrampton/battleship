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
    # Checks if .cells returns a Hash object
    assert_instance_of Hash, @board.cells
    # Checks if Hash has 16 key-value pairs
    assert_equal 16, @board.cells.size
    # Checks if the class of every key is String, and every value is Cell
    assert_equal true, @board.cells.keys.all? {|key| key.class == String}
    assert_equal true, @board.cells.values.all? {|value| value.class == Cell}
    # Checks if each key has a length of 2
    assert_equal 2, @board.cells.keys.sample.length
  end

  def test_it_can_identify_a_valid_coordinate
    assert_equal true, @board.valid_coordinate?("A4")
    assert_equal true, @board.valid_coordinate?("B2")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?("D5")
  end

  def test_
end
