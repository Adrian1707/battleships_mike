require 'ship'

describe Ship  do

  it 'initialize raises error when missing arguments' do
    expect{described_class.new()}.to raise_error(ArgumentError)
  end

  it 'has a size' do
    a = :size
    b = :location
    c = :orientation
    ship = Ship.new(a, b, c)
    expect(ship.size).to eq :size
  end

  it 'has a location' do
    a = :size
    b = :location
    c = :orientation
    ship = Ship.new(a, b, c)
    expect(ship.location).to eq :location
  end

  it 'has a orientation' do
    a = :size
    b = :location
    c = :orientation
    ship = Ship.new(a, b, c)
    expect(ship.orientation).to eq :orientation
  end

  it 'reduces in health by one with each hit' do
    ship = Ship.new(2, :location, :orientation)
    ship.hit
    expect(ship.health).to eq 1
  end

  it 'tells us when the ship has been sunk' do
    ship = Ship.new(2, :location, :orientation)
    ship.hit
    expect{ ship.hit }.to output("You have sunk my ship\n").to_stdout
  end

end