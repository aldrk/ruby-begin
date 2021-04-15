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
        station_list
      when 1
        create_train
      when 2
        create_station
      when 3
        create_route
      when 4
        add_station_to_route
      when 5
        remove_station_from_route
      when 6
        add_carriage
      when 7
        remove_carriage
      when 8
        move_train_to_next_station
      when 9
        move_train_to_prev_station
      when 10
        show_trains_on_station
      when 11
        define_train_route
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

  def station_list
    stations.each { |station| puts station.name }
  end

  def create_train
    begin
      puts 'Введите тип поезда(cargo - 1, passenger - 2)'
      type = gets.chomp.to_i
      raise RuntimeError unless [1, 2].include?(type)
    rescue RuntimeError
      puts 'Неправильный тип поезда'
      retry
    end

    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      type == 1 ? create_cargo_train(number) : create_passenger_train(number)
      puts "Был создан #{type == 1 ? 'грузововй' : 'пассажирский'} поезд с номером #{number}"
    rescue RuntimeError
      puts 'Неправильный номер поеда'
      retry
    end
  end

  def create_station
    puts 'Введите имя станции'
    name = gets.chomp
    stations << Station.new(name)
  end

  def create_route
    puts 'Введите начальный и конечный путь и номер маршрута'
    first_point = gets.chomp
    end_point = gets.chomp
    number = gets.chomp

    routes << Route.new(first_point, end_point, number)
  end

  def add_station_to_route
    puts 'Введите имя маршрута и имя новой станции'
    route_name = gets.chomp
    station_name = gets.chomp
    route = routes.filter { |route| route.name == route_name }
    station = stations.filter { |station| station.name == station_name }
    route.add_station(station)
  end

  def remove_station_from_route
    puts 'Введите имя маршрута и имя станции для удалениия'
    route_name = gets.chomp
    station_name = gets.chomp
    route = routes.filter { |route| route.name == route_name }
    station = stations.filter { |station| station.name == station_name }
    return unless route.include?(station)
    route.remove_station(station)
  end

  def define_train_route
    puts 'Введите номер поезда и маршрута'
    number = gets.chomp.to_i
    route_number = get.chomp.to_i
    train = trains.filter { |train| train.number == number }
    route = routes.filter { |route_item| route_item.number == route_number }
    train.define_route(route)
  end

  def add_carriage
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    train = trains.filter { |train| train.number == number }
    carriage = carriages.filter { |carriage| carriage.type == train.type }
    train.add_carriage(carriage)
  end

  def remove_carriage
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    train = trains.filter { |train| train.number == number }
    carriage = carriages.filter { |carriage| carriage.type == train.type }
    train.remove_carriage(carriage)
  end

  def move_train_to_next_station
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    train = trains.filter { |train| train.number == number }
    train.move_to_next_station
  end

  def move_train_to_prev_station
    puts 'Введите номер поезда'
    number = gets.chomp.to_i
    train = trains.filter { |train| train.number == number }
    train.move_to_prev_station
  end

  def show_trains_on_station
    puts 'Введите имя станции'
    station_name = gets.chomp
    station = stations.filter { |station| station.name == station_name }
    puts station.trains_on_station
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
end

Main.new.start