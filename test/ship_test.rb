require './test/test_helper.rb'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @ship = Ship.new("Cruiser", 3)
    @ship_2 = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Ship, @ship
  end

  def test_it_initializes_with_name_and_length
    assert_equal "Cruiser", @ship.name
    assert_equal 3, @ship.length
    assert_equal "Submarine", @ship_2.name
    assert_equal 2, @ship_2.length
  end

  # @health
  def test_health_equals_length
    assert_equal @ship.length, @ship.health
    assert_equal @ship_2.length, @ship_2.health
  end

  # .hit
  def test_hit_decreases_health_by_one
    assert_equal 3, @ship.health
    @ship.hit
    assert_equal 2, @ship.health
    @ship.hit
    assert_equal 1, @ship.health
    @ship.hit
    assert_equal 0, @ship.health
    @ship.hit
    assert_equal 0, @ship.health

    assert_equal 2, @ship_2.health
    @ship_2.hit
    assert_equal 1, @ship_2.health
    @ship_2.hit
    assert_equal 0, @ship_2.health
  end

  # .sunk?
  def test_it_is_sunk_or_not
    assert_equal 3, @ship.health
    @ship.hit
    assert_equal false, @ship.sunk?
    @ship.hit
    assert_equal false, @ship.sunk?
    @ship.hit
    assert_equal true, @ship.sunk?

    # second test on second ship
    assert_equal 2, @ship_2.health
    @ship_2.hit
    assert_equal false, @ship_2.sunk?
    @ship_2.hit
    assert_equal true, @ship_2.sunk?
  end

end
