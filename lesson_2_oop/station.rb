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

  def send_train(train, move_value)
    train.speed = 100
    train.move(move_value)

    accept_train.delete(train)
  end

  def show_trains_count_by_type
    passenger_count = 0
    freight_count = 0

    trains_on_station.each do |train|
      passenger_count += 1 if train.type == :passenger
      freight_count += 1 if train.type == :freight
    end

    puts "Now on station #{passenger_count} passenger's and #{freight_count} train(s)"
  end
end
