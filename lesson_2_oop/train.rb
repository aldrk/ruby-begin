class Train
  attr_accessor :number, :type, :speed, :train_route
  attr_reader :carriage_count, :current_station

  def initialize(number, type)
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
  end

  def move(moving_value)
    if moving_value == 1
      if @current_station != train_route.last_station
        moving_log(moving_value)
        @current_station += 1

        train_route.way[current_station].accept_train(self)
      end
    elsif moving_value == -1
      if @current_station != train_route.first_station
        moving_log(moving_value)
        @current_station -= 1

        train_route.way[current_station].accept_train(self)
      end
    end
  end

  def moving_log(moving_value)
    case current_station
    when 0
      puts "Current station #{train_route.way[0].name}. Next station #{train_route.way[1].name}"
    when train_route.last_station
      current = train_route.way[train_route.way.last_station].name
      next_station = train_route[train_route.way.last_station - 1].name

      puts "Current station #{current}. Next station #{next_station}"
    else
      current = train_route.way[current_station].name
      previous = train_route.way[current_station - moving_value].name
      next_station = train_route.way[current_station + moving_value].name

      puts "Current station #{current}. Previous station #{previous}. Next station #{next_station} "
    end
  end
end
