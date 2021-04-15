require_relative 'campaign_module'
require_relative 'instance_counter_module'

class Train
  attr_accessor :number, :type, :speed, :train_route
  attr_reader :current_station, :carriages

  include Campaign
  include InstanceCounter

  TRAIN_NUMBER_CHECK = /^(\d|[а-яА-Я]){3}\-*(\d|[а-яА-Я]){2}$/

  def initialize(number)
    @carriages = []
    @number = number
    validate_train!
    register_instance
    self.class.add_instance << self
  end

  class << self
    attr_reader :trains

    def add_instance
      @trains ||= []
    end

    def find(number)
      train = @trains.filter { |train| train.number == number }
      train || nil
    end
  end

  def add_carriage(carriage)
    @carriages << carriage if type == carriage.type
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if type == carriage.type
  end

  def define_route(route)
    @train_route = route
    @current_station = train_route.first_station
    @current_station.accept_train(self)
  end

  def move_to_next_station
    return if @current_station == train_route.last_station
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.accept_train(self)
  end

  def move_to_prev_station
    return if @current_station == train_route.first_station
    @current_station.send_train(self)
    @current_station = prev_station
    @current_station.accept_train(self)
  end

  def valid?
    validate_train!
    true
  rescue
    false
  end

  protected

  # так как это вспомогательный метод
  def current_station_idx
    train_route.way.find_index(current_station)
  end

  # так как это вспомогательный метод
  def prev_station
    train_route.way[current_station_idx - 1] if current_station != train_route.first_station
  end

  # так как это вспомогательный метод
  def next_station
    train_route.way[current_station_idx + 1] if current_station != train_route.last_station
  end

  def validate_train!
    raise RuntimeError if @number !~ TRAIN_NUMBER_CHECK
  end

end
