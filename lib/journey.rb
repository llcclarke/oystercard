

class Journey
  attr_reader :log

  MIN_FARE = 1
  PEN_FARE = 6


  def initialize(station = nil)
    @log = {entry: station, exit: nil}
  end

  def finish station
    @log[:exit] = station
    @log
  end

  def complete?
     !!@log[:entry] && !!@log[:exit]
  end

  def fare
    complete? ? MIN_FARE : PEN_FARE
  end


end
