require 'journey'

describe Journey do
  # it {is_expected.to respond_to(:fare)}
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  let(:first_half) {{entry: entry_station, exit: nil}}
  let(:un_begun) {{entry: nil, exit: nil}}
  let(:full_journey) {{entry: entry_station, exit: exit_station}}
  subject(:journey) {Journey.new entry_station}

  it "a new journey in not complete" do
    expect(subject).not_to be_complete
  end

  it "a journey starts at its beginning" do
    expect(subject.log).to eq first_half
  end

  it "a journey without a beginning has no start" do
    un_begun_journey = Journey.new
    expect(un_begun_journey.log).to eq un_begun
  end


  describe "#finish" do

    context "when tapped in already" do
      it 'makes entry and exit its bitches' do
        journey.finish exit_station
        expect(journey.log).to eq full_journey
      end
      it "journey is complete" do
        subject.finish exit_station
        expect(subject).to be_complete
      end
    end
    context "when not tapped in" do
      subject(:journey) {Journey.new}
      it 'shows journey not complete' do
        journey.finish exit_station
        expect(journey).not_to be_complete
      end
    end
  end
end
