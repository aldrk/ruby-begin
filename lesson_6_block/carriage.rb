require_relative 'campaign_module'

class Carriage
  include Campaign
  attr_reader :id

  def initialize(id)
    @id = id
  end
end
