require './test/test_helper.rb'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cell_2 = Cell.new("A1")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
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

  def test_fired_upon_starts_false
    assert_equal false, @cell.fired_upon?
    assert_equal false, @cell_2.fired_upon?
  end

  def test_empty_returns_true_initially
    assert_equal true, @cell.empty?
    assert_equal true, @cell_2.empty?
  end

  def test_it_is_not_empty_after_placing_ship
    @cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?

    @submarine = Ship.new("Submarine", 2)
    @cell_2.place_ship(@submarine)
    assert_equal false, @cell_2.empty?
  end

  def test_it_has_ship_after_placing_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship

    @cell_2.place_ship(@submarine)
    assert_equal @submarine, @cell_2.ship
  end

  def test_cell_has_not_been_fired_upon
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_fire_upon_lowers_ship_health_by_one
    @cell.place_ship(@submarine)
    @cell.fire_upon
    assert_equal 1, @cell.ship.health
  end

  def test_fire_upon_reduces_health
    @cell.place_ship(@cruiser)
    cruiser_starting_health = @cell.ship.health
    @cell.fire_upon
    assert_equal @cell.ship.health, cruiser_starting_health - 1

    @cell_2.place_ship(@submarine)
    submarine_starting_health = @cell_2.ship.health
    @cell_2.fire_upon
    assert_equal @cell_2.ship.health, submarine_starting_health - 1
  end

  def test_it_renders_cell_states
    assert_equal ".", @cell.render
    @cell.fire_upon
    assert_equal "M", @cell.render

    @cell_2.place_ship(@cruiser)
    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell_2.render
  end
end
