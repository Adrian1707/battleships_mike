require 'board'


describe Board do

  let(:ship){double(:ship, size: 2, location: "A1", orientation: "H")}
  let(:ship2){double(:ship, size: 2, location: "A2", orientation: "V")}
  let(:ship3){double(:ship, size: 1, location: "B2", orientation: "V")}
  let(:ship_big){double(:ship_big, size: 11, location: "A1", orientation: "H")}
  let(:ship_out){double(:ship_out, size: 1, location: "A13", orientation: "H")}
  let(:ship_off){double(:ship_off, size: 5, location: "C7", orientation: "H")}


  describe '#initialize' do

    it 'is created with an array(ocean)' do
      is_expected.to respond_to :ocean
    end

    it 'initializes with a 10x10 board' do
      expect(subject.ocean.count).to eq (10**2)
    end

  end

  it 'responds to ship_place method with 1 (i.e. the ship) arguments' do
    expect(subject).to respond_to(:ship_place).with(1).argument
  end

  it 'we would expect to see the ship in the ocean' do
    subject.ship_place(ship)
    expect( [subject.ocean[0], subject.ocean[1]] ).to eq [ship,ship]
  end

  it 'raises an error if ship is too big (size 11) for the board' do
    expect{ subject.ship_place(ship_big) }.to raise_error "Your ship is too big"
  end

  it 'raises an error if you place the ship outside of the board' do
    expect{ subject.ship_place(ship_out) }.to raise_error "Your ship is on the land"
  end

  it 'raises an error if your ship has any part outside the board' do
    expect{ subject.ship_place(ship_off) }.to raise_error "Part of your ship is on land"
  end

  it 'raises and error if your any part of your ship is on the same part of the ocean as another ship' do
    subject.ship_place(ship)
    expect{ subject.ship_place(ship2) }.to raise_error "You cannot place your ship on top of another ship"
  end

  describe '#shoot' do

    it "we would like to be able to fire a shot" do
      is_expected.to respond_to :shoot
    end

    it "we would like the shot to have a coordinate" do
      expect(subject).to respond_to(:shoot).with(1).argument
    end

    it 'raise an error if coordinate containing ship is hit twice' do
      subject.ship_place(ship)
      allow(ship).to receive(:hit)
      allow(ship).to receive(:health)
      subject.shoot("B1")
      expect{subject.shoot("B1")}.to raise_error "You've already hit this empty spot"
    end

    it 'raise an error if coordinate not contaning ship is hit twice' do
      subject.ship_place(ship)
      allow(ship).to receive(:hit)
      allow(ship).to receive(:health)
      subject.shoot("A1")
      expect{subject.shoot("A1")}.to raise_error "You've already hit this target"
    end

  end

  it "we would expect to register a hit if the shot hits part of a boat" do
    allow(ship).to receive(:class) {Ship}
    allow(ship).to receive(:health) {1}
    allow(ship).to receive(:hit) {nil}
    subject.ship_place(ship)
    expect{subject.shoot("A1")}.to output("Hit!\n").to_stdout
  end

  it "we would expect to register a miss if the shot hits part of a boat" do
    allow(ship).to receive(:class) {Ship}
    allow(ship).to receive(:health) {1}
    allow(ship).to receive(:hit) {nil}
    subject.ship_place(ship)
    expect{subject.shoot("B2")}.to output("Miss!\n").to_stdout
  end

  it "we would like to know when we have sunk an opponent's ship" do
    allow(ship).to receive(:class) {Ship}
    allow(ship).to receive(:health) {1}
    subject.ship_place(ship)
    allow(ship).to receive(:hit) {nil}
    subject.shoot("A2")
    allow(ship).to receive(:hit) {puts "You have sunk my ship"}
    expect{subject.shoot("A1")}.to output("Hit!\nYou have sunk my ship\n").to_stdout
  end

  it "tells you when you have won" do
    subject.ship_place(ship)
    subject.ship_place(ship3)
    allow(ship).to receive(:health) {0}
    allow(ship).to receive(:class) {Ship}
    allow(ship3).to receive(:health) {0}
    allow(ship3).to receive(:class) {Ship}
    allow(ship3).to receive(:hit) {puts "You have sunk my ship"}
    expect{ subject.shoot("B2") }.to output("Hit!\nYou have sunk my ship\nCongratulations! You have won the game!\n").to_stdout
  end


end
