class Route
  attr_accessor :way
  attr_reader :number

  def initialize(start_point, end_point, number)
    @way = [start_point, end_point]
    @number = number
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
