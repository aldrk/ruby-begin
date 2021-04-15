class Route
  attr_accessor :way
  attr_reader :number

  def initialize(start_point, end_point, number)
    @way = [start_point, end_point]
    @number = number
    validate_route!
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

  def valid?
    validate_route!
    true
  rescue
    false
  end

  protected

  def validate_number!
    raise 'Номер не должен быть пустым' if number.nil?
    raise 'Номер должен быть больше одного символа' if number.length < 2
  end

  def validate_points!
    length_check = first_station.length < 5 || last_station.length < 5
    raise 'Начальный или конечный маршрут не должны быть пустыми' if first_station.nil? || last_station.nil?
    raise 'Начальный или конечный маршрут не должны быть меньше 5 смволов' if length_check
  end

  def validate_route!
    validate_number!
    validate_points!
  end

end
