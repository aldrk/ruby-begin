module Accessor

  def attr_accessor_with_history(*names)
    history = '@value_history'
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_get = "#{name}=".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method(var_name_get) do |value|
        instance_variable_set(history, {}) unless instance_variable_defined?(history)
        history_value = instance_variable_get(history)
        history_value[name] ||= []
        history_value[name] << value
        instance_variable_set var_name, value
      end

      define_method("#{name}_history") do
        value = instance_variable_get(history)
        return [] if value.nil? || value[name].nil?

        value[name]
      end
    end
  end

  def strong_attr_accessor(name, type)
    variable_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(variable_name) }
    define_method("#{name}=".to_sym) do |value|
      instance_variable_set(variable_name, value) if value.instance_of?(type)
    end
  end
end
