module Campaign

  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
  end

  module InstanceMethods
    attr_reader :campaign_name

    def define_campaign_name(name)
      @campaign_name = name
    end
  end
end
