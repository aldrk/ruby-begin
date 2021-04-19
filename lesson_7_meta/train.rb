require_relative 'campaign_module'
require_relative 'instance_counter_module'

class Train
  extend Accessor
  include Campaign
  include InstanceCounter
  include Validation
  attr_accessor :number, :speed, :train_route
  attr_reader :current_station, :carriages

  attr_accessor_with_history :meow
  strong_attr_accessor(:atte_with_check, String)

  TRAIN_NUMBER_CHECK = /^(\d|[а-яА-Я]){3}\-*(\d|[а-яА-Я]){2}$/

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_CHECK

  def initialize(number)
    @carriages = []
    @number = number
    validate!
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

  def show_carriages
    carriages = []
    @carriages.each { |carriage| carriages << carriage.id }
    carriages.inspect
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
end
