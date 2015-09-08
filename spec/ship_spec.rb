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

end