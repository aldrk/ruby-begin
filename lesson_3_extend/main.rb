require_relative './station.rb'
require_relative './route.rb'
require_relative './cargo_carriage.rb'
require_relative './passenger_carriage.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'

class Main
  attr_reader :trains, :routes, :stations, :carriages

  STOP = 'stop'

  def initialize
    @trains = []
    @routes = []
    @stations = []
    @carriages = []
  end

  def start
    loop do
      menu_info

      menu = gets.chomp
      break if menu == STOP

      menu = menu.to_i

      case menu
      when 0
        stations.each { |station| puts station.name }
      when 1
        puts 'Введите номер и тип поезда(cargo, passenger)'
        number = gets.chomp
        type = gets.chomp
        puts "Неправильный тип поезда" if type != 'passenger' || 'cargo'
        type == 'passenger' ? create_passenger_train(number) : create_cargo_train(number)

      when 2
        puts 'Введите имя станции'
        name = gets.chomp
        create_station(name)

      when 3
        puts 'Введите начальный и конечный путь'
        first_point = gets.chomp
        end_point = gets.chomp
        create_route(first_point, end_point)

      when 4
        puts 'Введите имя маршрута и имя новой станции'
        route_name = gets.chomp
        station_name = gets.chomp
        route = routes.filter {|route| route.name == route_name}
        add_station_to_route(route, route_name)

      when 5
        puts 'Введите имя маршрута и имя станции для удалениия'
        route_name = gets.chomp
        station_name = gets.chomp
        route = routes.filter {|route| route.name == route_name}
        remove_station_from_route(route, route_name) if route

      when 6
        puts 'Введите номер поезда'
        number = gets.chomp
        train = trains.filter {|train| train.number == number}
        carriage = carriages.filter{|carriage| carriage.type == train.type}
        add_carriage(train, carriage) if train && carriage
      when 7
        puts 'Введите номер поезда'
        number = gets.chomp
        train = trains.filter {|train| train.number == number}
        carriage = carriages.filter{|carriage| carriage.type == train.type}
        remove_carriage(train, carriage) if train && carriage

      when 8
        puts 'Введите номер поезда'
        number = gets.chomp.to_i
        train = trains.filter {|train| train.number == number}
        move_train_to_next_station(train) if train

      when 9
        puts 'Введите номер поезда'
        number = gets.chomp.to_i
        train = trains.filter {|train| train.number == number}
        move_train_to_prev_station(train) if train

      when 10
        puts 'Введите имя станции'
        station_name = gets.chomp
        station = stations.filter {|station| station.name == station_name}
        show_trains_on_station(station) if station

      else
        puts 'Некорректное значение'
      end
    end
  end

  private
  # все private, так как пользователь взаимодействует с интерфейсом
  def menu_info
    puts '0 - посмотреть список станций'
    puts '1 - создать поезд'
    puts '2 - создать станцию'
    puts '3 - создать маршрут'
    puts '4 - добавить станцию в маршрут'
    puts '5 - удалить станцию из маршрута'
    puts '6 - добавить вагон поезду'
    puts '7 - удалить вагон из поезда'
    puts '8 - переместить поезд вперед'
    puts '9 - перместить поезд назад'
    puts '10 - посмотреть список поездов на станции'

    puts 'stop - чтобы выйти'
  end

  def create_station(name)
    stations << Station.new(name)
  end

  def create_route(start_point, end_point)
    routes << Route.new(start_point, end_point)
  end

  def create_passenger_train(number)
    trains << PassengerTrain.new(number)
  end

  def create_cargo_train(number)
    trains << CargoTrain.new(number)
  end

  def create_passenger_carriage
    trains << PassengerCarriage.new
  end

  def create_cargo_carriage
    trains << CargoCarriage.new
  end

  def add_station_to_route(route, station)
    route.add_station if stations.include?(station)
  end

  def remove_station_from_route(route, station)
    return unless route.include?(station)

    route.remove_station if station.class == Station && route.class == Route
  end

  def define_train_route(train, route)
    train.define_route(route) if routes.include?(route) && trains.include?(train)
  end

  def add_carriage(train, carriage)
    train.add_carriage(carriage) if @carriages.include?(carriage) && trains.include?(train)
  end

  def remove_carriage(train, carriage)
    train.remove_carriage(carriage) if @carriages.include?(carriage) && trains.include?(train)
  end

  def move_train_to_next_station(train)
    train.move_to_next_station if trains.include?(train)
  end

  def move_train_to_prev_station(train)
    train.move_to_prev_station if trains.include?(train)
  end

  def show_trains_on_station(station)
    puts station.trains_on_station if stations.include?(station)
  end
end

Main.new.start
