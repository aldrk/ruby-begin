class Station
  attr_accessor :trains_on_station, :name

  def initialize(name)
    @name = name
    @trains_on_station = []
    validate_station!
    self.class.add_instance << self
  end

  class << self
    attr_reader :all

    def add_instance
      @all ||= []
    end
  end

  def show_trains_by_type(type)
    trains_on_station.select { |train| train.type == type }
  end

  def valid?
    validate_station!
    true
  rescue
    false
  end

  private

  def accept_train(train)
    train.speed = 0

    trains_on_station << train
  end

  def send_train(train)
    train.speed = 100

    trains_on_station.delete(train)
  end

  protected

  def validate_station!
    raise 'Название не должен быть пустым' if name.nil?
    raise 'Название не должен быть меньше трех символов' if name.length < 3
  end
end
