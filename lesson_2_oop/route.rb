class Route
  attr_accessor :way

  def initialize(start_point, end_point)
    @way = []
    way << start_point << end_point
  end

  def add_station(station)
    new_way = way[0..way.size - 2]
    new_way << station << way[way.size - 1]

    @way = new_way
  end

  def remove_station(station)
    first_point = way[0]
    end_point = way[way.size]

    way.delete(station) if station != first_point || end_point
  end

  def route_list
    way.each do |route_item|
      puts route_item
    end
  end

  def first_station
    0
  end

  def last_station
    way.size
  end

end
