require 'board'


describe Board do

  let(:ship){double(:ship, size: 2, location: "A1", orientation: "H")}
  let(:ship_big){double(:ship_big, size: 3, location: "A1", orientation: "H")}
  let(:ship_out){double(:ship_out, size: 1, location: "A3", orientation: "H")}
  let(:ship_off){double(:ship_off, size: 2, location: "B1", orientation: "V")}

  it 'is created with an array(ocean)' do
    is_expected.to respond_to :ocean
  end

  it 'ocean returns an array of length 4' do
    expect(subject.ocean.count).to eq 4
  end

  it 'responds to ship_place method with 1 (i.e. the ship) arguments' do
    expect(subject).to respond_to(:ship_place).with(1).argument
  end

  it 'we would expect to see the ship in the ocean' do
    subject.ship_place(ship)
    expect(subject.ocean).to eq [ship,ship,"B1","B2"]
  end

  it 'raises an error if ship is too big (size 3) for the board' do
    expect{ subject.ship_place(ship_big) }.to raise_error "Your ship is too big"
  end

  it 'raises an error if you place the ship outside of the board' do
    expect{ subject.ship_place(ship_out) }.to raise_error "Your ship is on the land"
  end

  it 'raises an error if your ship has any part outside the board' do
    expect{ subject.ship_place(ship_off) }.to raise_error "Part of your ship is on land"
  end


end
