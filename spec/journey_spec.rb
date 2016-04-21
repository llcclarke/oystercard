require 'journey'

describe Journey do
  it {is_expected.to respond_to(:complete?)}

  it "a new journey in not complete" do
    expect(subject).not_to be_complete
  end

  describe "#entry" do
    let(:entry_station) {double :entry_station, name: 'station1', zone: 1}
    it 'makes the stations name and zone it\'s bitches' do
      expect(subject.start entry_station).to eq ['station1',1]
    end
  end

  describe "#exit" do
    let(:exit_station) {double :exit_station, name: 'station2', zone: 10}
    let(:half_journey) {{exit:['station2',10]}}
    it 'makes the stations name and zone it\'s bitches' do
      expect(subject.finish exit_station).to eq half_journey
    end

    context "when tapped in already" do
      let(:entry_station) {double :entry_station, name: 'station1', zone: 1}
      let(:fin_journey) {{entry:["station1",1],exit:['station2',10]}}
      before {subject.start entry_station}
      it 'makes entry and exit its bitches' do
        expect(subject.finish exit_station).to eq fin_journey
      end

      it "journey is complete" do
        subject.finish exit_station
        expect(subject).to be_complete
      end
    end
  end

end
