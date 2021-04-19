class Route
  include Validation
  attr_accessor :way
  attr_reader :number

  validate :way, :presence
  validate :number, :presence
  validate :class_type, :type, 'Route'


  def initialize(start_point, end_point, number)
    @way = [start_point, end_point]
    @class_type = self.class
    @number = number
    validate!
  end

  def add_station(station)
    @way.insert(-2, station)
  end

  def remove_station(station)
    way.delete(station) if station != first_station || last_station
  end

  def first_station
    puts way.first
    puts way.last
    way.first
  end

  def last_station
    way.last
  end
end
