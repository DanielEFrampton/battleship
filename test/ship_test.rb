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
end
