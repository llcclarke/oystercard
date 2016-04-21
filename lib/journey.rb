

class Journey
  attr_reader :log

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
  end
  private


end
