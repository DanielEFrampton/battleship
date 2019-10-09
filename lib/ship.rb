class Ship
  attr_reader :name, :length
  
  def initialize(name_parameter, length_parameter)
    @name = name_parameter
    @length = length_parameter
  end

end
