class Ship
  attr_reader :name, :length, :health, :hit

  def initialize(name_parameter, length_parameter)
    @name = name_parameter
    @length = length_parameter
    @health = length_parameter
  end

  def hit
    if @health > 0
      @health -= 1
    end
  end

  def sunk?
    @health <= 0
  end
end
