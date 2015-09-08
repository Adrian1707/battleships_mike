class Ship

  attr_reader :size, :location, :orientation, :health

  def initialize(size, location, orientation)
    @size = size
    @location = location
    @orientation = orientation
    @health = size
  end

  def hit
    @health = health - 1
    if @health == 0
      puts "You have sunk my ship"
    end
  end

end