require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = type_init
  end

  def type_init
    :passenger
  end
end
