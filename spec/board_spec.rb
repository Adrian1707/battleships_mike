require 'board'


describe Board do

  let(:ship){double(:ship, size: 2, location: "A1", orientation: "H")}

  it 'is created with an array(ocean) of length 4' do
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


end
