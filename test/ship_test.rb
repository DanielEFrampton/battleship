require 'minitest/autorun'
require 'minitest/pride'
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
    assert_equals "Cruiser", @ship.name
    assert_equals 3, @ship.length
    assert_equals "Submarine", @ship_2.name
    assert_equals 2, @ship_2.length
  end

  # @health
  def test_health_equals_length
    assert_equals @ship.length, @ship.health
    assert_equals @ship_2.length, @ship_2.health
  end

  # .hit
  def test_hit_decreases_health_by_one

    assert_equals 3, @ship.health
    @ship.hit
    assert_equals 2, @ship.health
    @ship.hit
    assert_equals 1, @ship.health
    @ship.hit
    assert_equals 0, @ship.health
    # Optional last assertion to ensure health can't go below zero:
    # @ship.hit
    # assert_equals 0, @ship.health

    assert_equals 2, @ship_2.health
    @ship_2.hit
    assert_equals 1, @ship_2.health
    @ship_2.hit
    assert_equals 0, @ship_2.health
  end

  # .sunk?
end
