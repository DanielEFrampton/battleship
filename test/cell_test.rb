require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cell_2 = Cell.new("A1")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
    assert_instance_of Cell, @cell_2
  end

  def test_coordinate_returns_cells_coordinate
    assert_equal "B4", @cell.coordinate
    assert_equal "A1", @cell_2.coordinate
  end

  def test_ship_returns_nil_initially
    assert_nil @cell.ship
    assert_nil @cell_2.ship
  end

  def test_empty_returns_true_initially
    assert_equal true, @cell.empty?
    assert_equal true, @cell_2.empty?
  end

  def test_it_has_ship_after_placing_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal cruiser, @cell.ship

    submarine = Ship.new("Submarine", 2)
    @cell_2.place_ship(submarine)
    assert_equal submarine, @cell_2.ship
  end

  def test_it_is_not_empty_after_placing_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal false, @cell.empty?

    submarine = Ship.new("Submarine", 2)
    @cell_2.place_ship(submarine)
    assert_equal false, @cell_2.empty?
  end

  def test_fired_upon_starts_false
    assert_equal false, @cell.fired_upon?
    assert_equal false, @cell_2.fired_upon?
  end
end
