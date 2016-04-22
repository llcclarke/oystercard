require 'station'

describe Station do

subject(:station) {Station.new("station_name",1)}

  it "has a name" do
    expect(station.name).to eq "station_name"
  end

  it "has a zone" do
    expect(station.zone).to eq 1
  end


end
