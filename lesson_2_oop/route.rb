class Route
  attr_accessor :route

  def initialize(start_point, end_point)
    @route = [] << start_point << end_point
  end

  def add_station(station)
    @route[route.size - 2] = station if route.size > 2
  end

  def remove_station(station)
    first_point = route[0]
    end_point = route[route.size]

    route.delete(station) if station != first_point || end_point
  end

  def route_list
    route.each do |route_item|
      puts route_item
    end
  end

  def first_station
    route.first
  end

  def last_station
    route.last
  end

end
