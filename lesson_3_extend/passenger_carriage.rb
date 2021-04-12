require_relative './carriage'

class PassengerCarriage < Carriage
  attr_reader :type

  def initialize
    @type = type_init
  end

  def type_init
    :passenger
  end
end
