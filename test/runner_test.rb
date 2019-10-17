require './test/test_helper.rb'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/runner'

class RunnerTest < Minitest::Test

  def setup
    @runner = Runner.new
  end

  def test_it_exists
    assert_instance_of Runner, @runner
  end

  def test_it_starts_without_a_game_in_its_game_variable
    assert_nil @runner.game
  end

end
