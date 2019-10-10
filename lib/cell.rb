class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate_parameter)
    @coordinate = coordinate_parameter
    @ship = nil
  end

  def empty?
    @empty
  end

  def place_ship(ship_object_parameter)
    @ship = ship_object_parameter
  end

  def fired_upon?
    false
  end

  def fire_upon
    if !empty?
      @ship.hit
    end
  end
end
