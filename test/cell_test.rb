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

  def test_ship_returns_nil
    assert_nil @cell.ship
    assert_nil @cell_2.ship
  end
end
