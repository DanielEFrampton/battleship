class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate_parameter)
    @coordinate = coordinate_parameter
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_object_parameter)
    @ship = ship_object_parameter
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if !empty?
      @ship.hit
    end
  end

  def render(display_ships_boolean = false)
    if fired_upon? && empty?
      "M"
    elsif !fired_upon? && !empty? && display_ships_boolean
      "S"
    elsif fired_upon? && !empty? && !@ship.sunk?
      "H"
    elsif fired_upon? && !empty? && @ship.sunk?
      "X"
    else
      "."
    end
  end
end
