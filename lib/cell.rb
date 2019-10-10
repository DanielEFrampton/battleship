class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate_parameter, ship = nil)
    @coordinate = coordinate_parameter
    @ship = ship
    @empty = true
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
    if @empty == true
      "Missed!"
    else
      @ship.hit
    end
  end
end
