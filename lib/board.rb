class Board
  attr_reader :cells

  def initialize
    @cells = {"A1" => Cell.new("A1"),
              "A2" => Cell.new("A2"),
              "A3" => Cell.new("A3"),
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"),
              "B2" => Cell.new("B2"),
              "B3" => Cell.new("B3"),
              "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"),
              "C2" => Cell.new("C2"),
              "C3" => Cell.new("C3"),
              "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"),
              "D2" => Cell.new("D2"),
              "D3" => Cell.new("D3"),
              "D4" => Cell.new("D4")
              }
  end

  def valid_coordinate?(coordinate_parameter)
    @cells.keys.include?(coordinate_parameter)
  end

  def valid_placement?(ship_object_parameter, array_of_coordinates)
    unless array_of_coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
      return false
    end

    if array_of_coordinates.any? { |coordinate| !@cells[coordinate].empty? }
      return false
    end

    # Confirm that length of array is same as ship length
    if ship_object_parameter.length == array_of_coordinates.length
      letters = []
      numbers = []
      array_of_coordinates.each do |coordinate|
        letters << coordinate.chars[0]
        numbers << coordinate.chars[1].to_i
      end
      all_letters_are_same = letters.all? { |letter| letter == letters[0] }
      all_numbers_are_same = numbers.all? { |number| number == numbers[0] }
      numbers_are_in_order = (numbers.first..numbers.last).to_a == numbers
      letters_are_in_order = (letters.first..letters.last).to_a == letters
      all_letters_are_same && numbers_are_in_order || letters_are_in_order && all_numbers_are_same
    else
      false
    end
  end

  def place(ship_object_parameter, coord_array)
    coord_array.each do |coordinate|
      @cells[coordinate].place_ship(ship_object_parameter)
    end
  end

  def render(show_ships_boolean = false)
    "  1 2 3 4 \n" +
    "A #{["A1", "A2", "A3", "A4"].map { |coord| @cells[coord].render(show_ships_boolean)}.join(" ")} \n" +
    "B #{["B1", "B2", "B3", "B4"].map { |coord| @cells[coord].render(show_ships_boolean)}.join(" ")} \n" +
    "C #{["C1", "C2", "C3", "C4"].map { |coord| @cells[coord].render(show_ships_boolean)}.join(" ")} \n" +
    "D #{["D1", "D2", "D3", "D4"].map { |coord| @cells[coord].render(show_ships_boolean)}.join(" ")} \n"
  end
end
