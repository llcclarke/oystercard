require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeys

  DEFAULT_LIMIT = 90.00
  MINIMUM_BALANCE = 1.00
  FARE = 1.00

  def initialize
    @balance = 0.00
    @journeys = []
    @journey = nil
  end

  def top_up(money)
    fail top_up_fail_message if limit_reached?(money)
    @balance += money
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    fail no_credit_message if not_enough_credit?
    double_touch_in
    @journey = Journey.new station
  end

  def touch_out(station)
    @journey = Journey.new if no_entry_station?
    @journeys << @journey.finish(station)
    deduct
    @journey = nil

  end



private

  def not_enough_credit?
    @balance < MINIMUM_BALANCE
  end

  def limit_reached?(money)
    @balance + money > DEFAULT_LIMIT
  end

  def deduct
    @balance -= @journey.fare
  end

  def top_up_fail_message
    "Top up amount pushes you over your maximum oyster card limit of £#{DEFAULT_LIMIT}. Your current balance is £#{@balance}"
  end

  def no_entry_station?
    @journey.nil?
  end

  def double_touch_in
    if @journey != nil
      @journeys << @journey.log
      deduct
    end
  end

  def no_credit_message
    "Please top up, not enough credit"
  end


end
