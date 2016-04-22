

class Journey
  attr_reader :log

  MIN_FARE = 1.00
  PEN_FARE = 6.00


  def initialize(station = nil)
    @log = {entry: station, exit: nil}
  end

  def finish station
    @log[:exit] = station
    @log
  end

  def complete?
    true unless @log[:entry] ==nil || @log[:exit] == nil
  end

  def fare
    complete? ? MIN_FARE : PEN_FARE
  end


end
