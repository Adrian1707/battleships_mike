class Board

"Mike Test 2"

  attr_reader :ocean, :map

  def initialize
    @ocean = ["A1","A2","B1","B2"]
    @map =  ["A1","A2","B1","B2"]
  end

  def ship_place(ship)
    onboard_fail(ship)
    overlap_fail(ship)
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

  def shoot(shot)
    i = map.index(shot)
    if ocean[i] != map[i]
      puts "Hit!"
      ocean[i].hit
      puts "Congratulations! You have won the game!" if winner?
    else
      puts "Miss!"
    end

  end

  private


  def winner?
    ocean.select{ |s| s.class == Ship }.each do |s|
      if s.health > 0
        return false
      end
    end
    return true
  end



  def onboard_fail(ship)
    board_width = ocean.count**0.5
    i = map.index(ship.location)
    o = ship.orientation.downcase

    fail "Your ship is too big" if ship.size > board_width
    fail "Your ship is on the land" if !map.include?(ship.location)
    fail "Part of your ship is on land" if (o == "h" && (i%board_width)+ship.size > board_width) || (o == "v" && (i/board_width.to_i)+ship.size > board_width)
  end

  def overlap_fail(ship)
    board_width = (ocean.count**0.5).to_i
    i = map.index(ship.location)
    n = 1
    fail "You cannot place your ship on top of another ship" if ocean[i] != map[i]
    while n < ship.size
      if ship.orientation.downcase == "v"
        i+=board_width
        fail "You cannot place your ship on top of another ship" if ocean[i] != map[i]
      elsif ship.orientation.downcase == "h"
        i+=1
        fail "You cannot place your ship on top of another ship" if ocean[i] != map[i]
      end
      n+=1
    end

  end

end
