class Journey

  def initialize
    @log = {}
  end

  def start station
    @log[:entry] = [station.name, station.zone]
  end

  def finish station
    @log[:exit] = [station.name, station.zone]
    log
  end

  def complete?
     @log.includes? @log[exit]
  end

  private
  attr_reader :log

end
