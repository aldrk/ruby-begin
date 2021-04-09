require_relative './station.rb'
require_relative './route.rb'
require_relative './cargo_carriage.rb'
require_relative './passenger_cargo.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'

class Main
  attr_reader :trains, :routes, :stations, @carriages

  def initialize
    @trains = []
    @routes = []
    @stations = []
    @carriages = []
  end

  def create_station(name)
    stations << Station.new(name)
  end

  def create_route(start_point, end_point)
    routes << Route.new(start_point, end_point)
  end

  def create_train(number, type)
    trains << type == :cargo ? CargoTrain.new(number) : PassengerTrain.new(number)
  end

  def create_carriage(type)
    @carriages << type == :cargo ? CargoCarriage.new : PassengerCarriage.new
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

  def show_trains_on_station(train)
    puts train.trains_on_station if trains.include?(train)
  end
end