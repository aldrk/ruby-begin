require_relative './carriage'

class CargoCarriage < Carriage
  attr_reader :type

  def initialize
    @type = type_init
  end

  def type_init
    :cargo
  end
end
