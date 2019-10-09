class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate_parameter)
    @coordinate = coordinate_parameter
    @ship = nil
  end

  def empty?
    true
  end

  def place_ship(ship_object_parameter)
    @ship = ship_object_parameter
  end
end
