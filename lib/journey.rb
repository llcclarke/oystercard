

class Journey
  attr_reader :log

  def initialize
    @log = {}
  end

  def start station
    @log[:entry] = [station.name, station.zone]
  end

  def finish station
    @log[:exit] = [station.name, station.zone]
    @log
  end

  def complete?
     @log.keys.include? :exit
  end

  private


end
