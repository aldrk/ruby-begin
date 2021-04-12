require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = type_init
  end

  def type_init
    :cargo
  end
end
