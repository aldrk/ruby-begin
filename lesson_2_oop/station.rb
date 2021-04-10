class Station
  attr_accessor :trains_on_station, :name

  def initialize(name)
    @name = name
    @trains_on_station = []
  end

  def accept_train(train)
    train.speed = 0

    trains_on_station << train
  end

  def send_train(train)
    train.speed = 100

    trains_on_station.delete(train)
  end

  def show_trains_by_type(type)
    trains_on_station.select { |train| train.type == type }
  end
end
