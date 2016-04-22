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


let (:entry_station) {double :entry_station, name: "stn1", zone: 1}
let (:exit_station) {double :exit_station, name: "stn2", zone: 5}


  describe "#touch_in" do
    let(:journey) {{entry: ["stn1", 1]}}
    it 'changes the journey status to true' do
      subject.top_up Oystercard::MINIMUM_BALANCE
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'raises an error if balance below minimun limit' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Please top up, not enough credit"
    end


     context "when have not touched out" do
      let(:journey) {{entry: entry_station, exit: nil}}

      it "shows nil entry station" do
        no_exit = Oystercard.new
        no_exit.top_up 10
        no_exit.touch_in(entry_station)
        no_exit.touch_in(entry_station)
        expect(no_exit.journeys).to include journey
      end

      it "deducts penalty fare when touching in again" do
        no_exit = Oystercard.new
        no_exit.top_up 10
        no_exit.touch_in(entry_station)
        expect{ no_exit.touch_in(entry_station) }.to change { no_exit.balance }.by -Journey::PEN_FARE

      end
    end
  end

  describe "#touch_out" do
    let(:journey) {{entry: entry_station, exit: exit_station}}

    before {subject.top_up Oystercard::MINIMUM_BALANCE}
    before {subject.touch_in(entry_station)}

#change
    it "deducts the fare from the oystercard" do
      expect{ subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::FARE
    end



    it "saves the exit station in the journey history" do
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end

    context "when not touched" do
      let(:journey) {{entry: nil, exit: exit_station}}
      it "shows nil entry station" do
        no_entry = Oystercard.new
        no_entry.touch_out(exit_station)
        expect(no_entry.journeys).to include journey
      end
      it "deducts penalty fare from card if no touch in" do
        no_entry = Oystercard.new
        no_entry.top_up 10
        expect{ no_entry.touch_out(exit_station) }.to change { no_entry.balance }.by -Journey::PEN_FARE
    end
    end

  end
end
