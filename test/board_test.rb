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

    # Confirms each key is made up of A-D and 1-4
    letter_range = ("A".."D").to_a
    number_range = (1..4).to_a
    possible_combinations = []
    letter_range.each do |letter|
      number_range.each do |number|
        possible_combinations << "#{letter}#{number}"
      end
    end
    assert_equal true, @board.cells.keys.all? {|key| possible_combinations.include?(key)}
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

  def test_it_denies_valid_placement_when_length_of_cells_is_wrong
    # Confirms return value is false if number of cells is different than length of ship
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"]) # Too short
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"]) # Too long
    assert_equal false, @board.valid_placement?(@submarine, ["A2"]) # Too short
  end

  def test_it_denies_valid_placement_when_cells_are_not_consecutive_or_misordered
    # Confirms return value is false if placement cells are non-consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"]) # Missing A3
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"]) # Missing B1
  end

  def test_it_denies_valid_placement_when_cells_are_not_left_to_right_or_top_to_bottom
    # Confirms return value is false if cells are not in left-to-right or top-to-bottom order
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"]) # Right-to-left
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"]) # Bottom-to-top
  end

  def test_it_denies_valid_placement_when_cells_are_diagonal
    # Confirms return value is false if placement cells are diagonal
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(submarine, ["C2", "D3"])
  end

  def
end
