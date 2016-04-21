require "oystercard"

describe Oystercard do


  describe "#initalize" do
    it "starts with a balance of zero" do
      expect(subject.balance).to eq 0
    end
    it 'starts with an empty journey history' do
    expect(subject.journeys).to be_empty
    end
  end

  describe "#top_up" do
    it "increase balance by set amount" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe "#limit_reached?" do
    it "raise error if #top_up(amount) puts balance over maximum limit." do
      msg1 = "Top up amount pushes you over your maximum oyster card limit of £#{Oystercard::DEFAULT_LIMIT}."
      msg2 =  "Your current balance is £#{subject.balance}"
      expect{ subject.top_up 91 }.to raise_error "#{msg1} #{msg2}"
    end
end


let (:entry_station) {double :journey}
let (:exit_station) {double :journey}

# MAKE JOURNEY REMEMBER ENTRY AND EXIT STATIONS

  describe "#touch_in" do
    let (:station) {double :station}
    let(:journey) {{entry: station}}
    it 'changes the journey status to true' do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'raises an error if balance below minimun limit' do
      expect{ subject.touch_in(station) }.to raise_error "Please top up, not enough credit"
    end

    it "saves the entry station in current journey" do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(station)
      expect(subject.journey).to eq journey
    end
  end

  describe "#touch_out" do
    let(:station) {double :station}
    let(:station2) {double :station2}
    let(:journey) {{entry: station, exit: station2}}

    before {subject.top_up Oystercard::MINIMUM_BALANCE}
    before {subject.touch_in(station)}


    it "deducts the fare from the oystercard" do
      expect{ subject.touch_out(station) }.to change { subject.balance }.by -Oystercard::FARE
    end

    it "saves the exit station in the journey history" do
      subject.touch_out(station2)
      expect(subject.journeys).to include journey
    end

    it "resets journey to empty" do
      subject.touch_out(station2)
      expect(subject.journey).to be_empty
    end
  end
end
