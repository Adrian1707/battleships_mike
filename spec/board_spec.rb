require 'board'

describe Board do
  it 'is created with an array(ocean) of length 4' do
    is_expected.to respond_to :ocean
  end

  it 'ocean returns an array of length 4' do
    expect(subject.ocean.count).to eq 4
  end

  it 'responds to ship_place method with 3 arguments' do
    expect(subject).to respond_to(:ship_place).with(3).arguments
  end


end
