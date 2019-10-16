require './test/test_helper.rb'
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

    # Confirms the class of every value is Cell
    assert_equal true, @board.cells.values.all? {|value| value.class == Cell}
  end

  def test_it_has_hash_of_coordinate_string_keys
    # Confirms the class of every key is String
    assert_equal true, @board.cells.keys.all? {|key| key.class == String}

    # Confirms each key has a length of 2
    assert_equal true, @board.cells.keys.all? {|key| key.length == 2}

    # Confirms each key is made up of A-D and 1-4; consider moving code to class itself
    possible_combinations = ("A".."D").reduce([]) do |coord_array, letter|
      coord_array += (1..4).map { |number| "#{letter}#{number}" }
    end
    assert_equal true, @board.cells.keys.all? {|key| possible_combinations.include?(key)}

    # Add check to confirm coordinate of cell is same as key
    assert_equal 0, @board.cells.count {|key, cell| cell.coordinate != key}
  end

  def test_it_starts_with_no_previous_random_shot
    assert_nil @board.previous_random_shot
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
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_it_confirms_valid_placement
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
    assert_equal true, @board.valid_placement?(@submarine, ["C2", "C3"])
    assert_equal true, @board.valid_placement?(@submarine, ["C2", "D2"])
  end
  # Test .place
  def test_it_denies_edge_case_values_as_valid_placements
    assert_equal false, @board.valid_placement?(@cruiser, ["A0", "B0", "C0"])
    assert_equal false, @board.valid_placement?(@submarine, [nil, nil])
  end

  def test_it_can_place_same_ship_in_multiple_cells
    # Testing on first ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal @cruiser, @board.cells["A1"].ship
    assert_equal @cruiser, @board.cells["A2"].ship
    assert_equal @cruiser, @board.cells["A3"].ship
    assert_same @board.cells["A1"].ship, @board.cells["A2"].ship

    # Testing on second ship in different location
    @board.place(@submarine, ["C4", "D4"])
    assert_equal @submarine, @board.cells["C4"].ship
    assert_equal @submarine, @board.cells["D4"].ship
    assert_same @board.cells["C4"].ship, @board.cells["D4"].ship
  end

  # Test that .place does not allow overlapping ships
  def test_it_denies_valid_placement_if_ship_is_in_any_cells
    # Testing first ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "B2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A3", "B3"])

    assert_equal true, @board.valid_placement?(@submarine, ["B1", "B2"]) # Horizontal
    assert_equal true, @board.valid_placement?(@submarine, ["B1", "C1"]) # Vertical
  end

  # Test .render method
  def test_it_can_render_initial_board_state
    # Testing what board should render as after ships placed, but before any player turns occur
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["C4", "D4"])
    beginning_board_render = "  1 2 3 4 \n" +
                             "A . . . . \n" +
                             "B . . . . \n" +
                             "C . . . . \n" +
                             "D . . . . \n"
    assert_equal beginning_board_render, @board.render

    # Testing what board should render as with "true" optional parameter, showing ships
    ship_placed_board_render =  "  1 2 3 4 \n" +
                                "A S S S . \n" +
                                "B . . . . \n" +
                                "C . . . S \n" +
                                "D . . . S \n"
    assert_equal ship_placed_board_render, @board.render(true)
  end

  # Add tests later for board state after cells have been fired upon, ships sunk, etc.

  def test_it_can_pick_random_coord
    assert_equal true, @board.cells.keys.include?(@board.random_coord)
  end

  def test_it_can_pick_random_cell
    assert_instance_of Cell, @board.random_cell
    assert_equal true, @board.cells.values.include?(@board.random_cell)
  end

  def test_it_can_place_ship_randomly
    @board.place_ship_randomly(@cruiser)
    assert_equal @cruiser.length, @board.cells.values.count{|cell| cell.ship == @cruiser}
    @board.place_ship_randomly(@submarine)
    assert_equal @submarine.length, @board.cells.values.count{|cell| cell.ship == @submarine}
  end

  def test_it_shoots_at_random_coordinate
    @board.fire_upon_random_cell
    assert_equal 1, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 2, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 3, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 4, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 5, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 6, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 7, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 8, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 9, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 10, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 11, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 12, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 13, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 14, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 15, @board.cells.values.count { |cell| cell.fired_upon? }
    @board.fire_upon_random_cell
    assert_equal 16, @board.cells.values.count { |cell| cell.fired_upon? }
  end

  def test_it_remembers_previous_random_shot
    @board.fire_upon_random_cell
    assert_equal true, @board.valid_coordinate?(@board.previous_random_shot)
  end

  def test_it_return_list_of_all_ships_on_board
    @board.place_ship_randomly(@cruiser)
    @board.place_ship_randomly(@submarine)
    expected_array = [@cruiser, @submarine].sort_by {|ship| ship.name}
    assert_equal expected_array, @board.all_ships.sort_by {|ship| ship.name}
  end

  def test_it_can_check_if_all_ships_sunk
    @board.place_ship_randomly(@cruiser)
    @board.place_ship_randomly(@submarine)
    assert_equal false, @board.all_ships_sunk?
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal false, @board.all_ships_sunk?
    @submarine.hit
    @submarine.hit
    assert_equal true, @board.all_ships_sunk?
  end

  def test_it_can_check_if_cell_fired_upon
    assert_equal false, @board.cell_fired_upon?("A1")
    @board.cells["A1"].fire_upon
    assert_equal true, @board.cell_fired_upon?("A1")

    assert_equal false, @board.cell_fired_upon?("D2")
    @board.cells["D2"].fire_upon
    assert_equal true, @board.cell_fired_upon?("D2")
  end

  def test_it_can_fire_upon_cell
    assert_equal false, @board.cell_fired_upon?("A1")
    @board.fire_upon_cell("A1")
    assert_equal true, @board.cell_fired_upon?("A1")

    assert_equal false, @board.cell_fired_upon?("D2")
    @board.fire_upon_cell("D2")
    assert_equal true, @board.cell_fired_upon?("D2")
  end

  def test_it_can_return_string_of_shot_result
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.fire_upon_cell("A1")
    assert_equal "was a hit", @board.shot_result("A1")
    @board.fire_upon_cell("A2")
    @board.fire_upon_cell("A3")
    assert_equal "sank the Cruiser", @board.shot_result("A1")
    assert_equal "sank the Cruiser", @board.shot_result("A2")
    assert_equal "sank the Cruiser", @board.shot_result("A3")
    @board.fire_upon_cell("D3")
    assert_equal "was a miss", @board.shot_result("D3")
  end
end
