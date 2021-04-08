class Train
  attr_accessor :number, :type, :speed, :train_route
  attr_reader :carriage_count, :current_station

  def initialize(number, type, carriage_count)
    @carriage_count = carriage_count if carriage_count.positive?
    @number = number
    @type = type
  end

  def add_carriage
    @carriage_count += 1 if speed.zero?
  end

  def remove_carriage
    @carriage_count -= 1 if speed.zero? && !@carriage_count.zero?
  end

  def define_route(route)
    @train_route = route

    @current_station = train_route.first_station
    @current_station.accept_train(self)
  end

  def current_station_idx
    train_route.way.find_index(current_station)
  end

  def prev_station
    if current_station != train_route.first_station
      train_route.way[current_station_idx - 1]
    else
      puts 'No previous station'
    end
  end

  def next_station
    if current_station != train_route.last_station
      train_route.way[current_station_idx + 1]
    else
      puts 'No next station'
    end
  end

  def move_to_next_station
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.accept_train(self)
  end

  def move_to_prev_station
    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.accept_train(self)
  end

end
