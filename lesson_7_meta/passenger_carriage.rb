require_relative './carriage'

class PassengerCarriage < Carriage
  attr_reader :type, :places_count, :filled_places

  def initialize(id, places_count)
    super(id)
    @places_count = places_count
    validate_passenger_carriage!
    @type = type_init
    @filled_places = []
  end

  def type_init
    :passenger
  end

  def fill_place(num)
    raise "Место должно быть от 1 до #{places_count}" if num > places_count
    raise 'Место занято' if filled_places.include? num

    filled_places << num
  end

  def empty_places_count
    places_count - :filled_places.size
  end

  def filled_places_count
    :filled_places.size
  end

  def valid?
    validate_passenger_carriage!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate_passenger_carriage!
    raise 'Число мест не должно быть пустым' if @places_count.zero?
  end
end
