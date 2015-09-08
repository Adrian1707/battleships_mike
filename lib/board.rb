class Board

  attr_reader :ocean, :map

  def initialize
    @ocean = ["A1","A2","B1","B2"]
    @map =  ocean
  end

  def ship_place(ship)
    i = map.index(ship.location)
    n = 1
    ocean[i] = ship
    while n < ship.size
      if ship.orientation.downcase == "v"
        i+=2
        ocean[i] = ship
      elsif ship.orientation.downcase == "h"
        i+=1
        ocean[i] = ship
      end
      n+=1
    end
  end

end
