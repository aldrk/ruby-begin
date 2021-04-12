class Carriage
  attr_reader :type

  def initialize
    @type = type_init
  end

  def type_init
    nil
  end
end
