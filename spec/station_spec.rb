require 'station'

describe Station do

let(:station) {Station.new("station_name",1)}

  it "has a name" do
    expect(station.name).to eq "station_name"
  end

  it "responds to zone" do
    expect(station).to respond_to(:zone)
  end

  it "has a zone" do
    expect(station.zone).to eq 1
  end


end
