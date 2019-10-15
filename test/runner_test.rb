require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/runner'

class RunnerTest < Minitest::Test

  def setup
    
  end

  def test_it_exists
    assert_instance_of Runner, @runner
  end

end
