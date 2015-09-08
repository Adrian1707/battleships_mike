class Ship

  attr_reader :size, :location, :orientation

  def initialize(size, location, orientation)
    @size = size
    @location = location
    @orientation = orientation
  end

end