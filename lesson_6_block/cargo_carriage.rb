require_relative './carriage'

class CargoCarriage < Carriage
  attr_reader :type, :volume, :filled_volume

  def initialize(id, volume)
    super(id)
    @type = type_init
    @volume = volume
    @filled_volume = 0
    validate_cargo_train!
  end

  def type_init
    :cargo
  end

  def empty_volume
    volume - filled_volume
  end

  def fill_volume(volume_to_fill)
    raise "Объем не должен быть больше #{empty_volume}" if volume_to_fill > empty_volume

    @filled_volume += volume
  end

  def valid?
    validate_cargo_train!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate_cargo_train!
    raise 'Объем не должен быть пустым' if @volume.nil?
  end
end
