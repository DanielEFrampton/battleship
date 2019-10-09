class Cell
  attr_reader :coordinate

  def initialize(coordinate_parameter)
    @coordinate = coordinate_parameter
  end

  def ship
    nil
  end
end
