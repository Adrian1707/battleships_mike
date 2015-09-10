require_relative 'board'

class Game

attr_accessor :board

  def initialize
  @board1 = Board.new
  @board2 = Board.new
  puts "Let's begin. Player 1, enter your name"
  @player1 = gets.chomp
  puts ""
  puts "Now Player 2, enter your name"
  @player2 = gets.chomp
  puts ""
  puts "Great. Now let's play!"
  player1_create_ship
  player2_create_ship
  player1_fire
  end

  def player1_create_ship
    puts "#{@player1}, place your ships"
    3.times do
    size = rand(1..5)
    puts "Enter coordinate of boat"
    location = gets.chomp.to_s
    puts "Enter orientation of boat"
    orientation = gets.chomp.to_s
    ship = Ship.new(size, location, orientation)
    @board1.ship_place(ship)
      end
    end

def player2_create_ship
  puts " "
  puts ""
  puts "#{@player2}, now place your ships"
  3.times do
  size = rand(1..5)
  puts "Enter coordinate of boat"
  location = gets.chomp.to_s
  puts "Enter orientation of boat"
  orientation = gets.chomp.to_s
  ship = Ship.new(size, location, orientation)
  @board2.ship_place(ship)
  end
end

  def player1_fire
    puts "#{@player1}, take your shots"
    10.times do
    shot = gets.chomp
    @board2.shoot(shot)
    end
  end

  def player2_fire
    puts "#{@player2}, take your shots"
    10.times do
    shot = gets.chomp
    @board1.shoot(shot)
    end
  end



end
