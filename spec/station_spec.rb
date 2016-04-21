require 'station'

describe Station do

let(:station) {Station.new("station_name")}

  it "has a name" do
    expect(station.name).to eq "station_name"
  end

  it "has a zone" do
    expect(station).to respond_to(zone)
  end


end
