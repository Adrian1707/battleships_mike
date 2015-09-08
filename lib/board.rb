class Board

  attr_reader :ocean, :map

  def initialize
    @ocean = ["A1","A2","B1","B2"]
    @map =  ocean
  end

  def ship_place(ship)
    onboard_fail(ship)
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

  def onboard_fail(ship)
    board_width = ocean.count**0.5
    i = map.index(ship.location)
    o = ship.orientation.downcase

    fail "Your ship is too big" if ship.size > board_width
    fail "Your ship is on the land" if !ocean.include?(ship.location)
    fail "Part of your ship is on land" if (o == "h" && i+ship.size > board_width) || (o == "v" && i+((board_width)*ship.size) > ocean.count)
  end

end
