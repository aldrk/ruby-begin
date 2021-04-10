class Route
  attr_accessor :way

  def initialize(start_point, end_point)
    @way = [start_point, end_point]
  end

  def add_station(station)
    @way.insert(-2, station)
  end

  def remove_station(station)
    way.delete(station) if station != first_station || last_station
  end

  def first_station
    way.first
  end

  def last_station
    way.last
  end

end