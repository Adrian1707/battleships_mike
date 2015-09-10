class Board

  attr_reader :ocean, :map, :hits, :misses

  def initialize
    @ocean = ["A1","A2","A3","A4","A5","A6","A7","A8","A9","A10",
              "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10",
              "C1","C2","C3","C4","C5","C6","C7","C8","C9","C10",
              "D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
              "E1","E2","E3","E4","E5","E6","E7","E8","E9","E10",
              "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10",
              "G1","G2","G3","G4","G5","G6","G7","G8","G9","G10",
              "H1","H2","H3","H4","H5","H6","H7","H8","H9","H10",
              "I1","I2","I3","I4","I5","I6","I7","I8","I9","I10",
              "J1","J2","J3","J4","J5","J6","J7","J8","J9","J10"]

    @map =  [ "A1","A2","A3","A4","A5","A6","A7","A8","A9","A10",
              "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10",
              "C1","C2","C3","C4","C5","C6","C7","C8","C9","C10",
              "D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
              "E1","E2","E3","E4","E5","E6","E7","E8","E9","E10",
              "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10",
              "G1","G2","G3","G4","G5","G6","G7","G8","G9","G10",
              "H1","H2","H3","H4","H5","H6","H7","H8","H9","H10",
              "I1","I2","I3","I4","I5","I6","I7","I8","I9","I10",
              "J1","J2","J3","J4","J5","J6","J7","J8","J9","J10"]

    @hits = []
    @misses = []
  end

  def ship_place(ship)
    onboard_fail(ship)
    overlap_fail(ship)
    board_width = (ocean.count**0.5).to_i #board_width will always be square root of board size as it's a square
    i = map.index(ship.location) #find the index of the map array that contains the ships location. So is location is A1, i = 0
    n = 1
    ocean[i] = ship #we place the ship here in the ocean at the index where the ship position was stated. Place on ocean for now, then compare with map later on for overlaps
                    #Also comparing map and ocean to see if there's a hit. If ocean[i] != map[i]
     while n < ship.size
      if ship.orientation.downcase == "v"
        i += board_width
        ocean[i] = ship
      elsif ship.orientation.downcase == "h"
        i += 1
        ocean[i] = ship
      end
      n += 1
    end
  en

  def shoot(shot)
    fail "You've already hit this target" if @hits.include? shot
    fail "You've already hit this empty spot" if @misses.include? shot
    i = map.index(shot)
    if ocean[i] != map[i] #is ocean[i] does not contain the same value as map[i], a ship must be placed in ocean, so its a hit
      puts "Hit!"
      ocean[i].hit
      @hits << shot
      puts "Congratulations! You have won the game!" if winner?
    else
      puts "Miss!"
      @misses << shot
    end

  end

  private

  #
  # def winner?
  #   ocean.select{ |s| s.class == Ship }.each do |s|
  #     if s.health > 0
  #       return false
  #     end
  #   end
  #   return true
  # end



  def onboard_fail(ship)
    board_width = (ocean.count**0.5).to_i
    i = map.index(ship.location)
    o = ship.orientation.downcase

    fail "Your ship is too big" if ship.size > board_width
    fail "Your ship is on the land" if !map.include?(ship.location)
    fail "Part of your ship is on land" if (o == "h" && (i%board_width)+ship.size > board_width) || (o == "v" && (i/board_width)+ship.size > board_width)
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
