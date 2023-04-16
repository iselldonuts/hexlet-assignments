# frozen_string_literal: true

# BEGIN
module Model
  def attribute(name, options = {})
    define_method name do
      var = instance_variable_get "@#{name}"
      cast(var, options[:type])
    end

    define_method "#{name}=" do |value|
      instance_variable_set "@#{name}", value
    end
  end

  def initialize(params = {})
    params.each_pair do |prop, value|
      send "#{prop}=", value
    end
  end

  def attributes
    instance_variables.to_h do |var|
      sym = var[1..].to_sym
      [sym, send(sym)]
    end
  end

  def self.included(object)
    object.extend(self)
  end

  private

  def cast(var, type)
    case type
    when :integer
      var.to_i
    when :string
      var.to_s
    when :boolean
      var.to_s.downcase == 'true'
    when :datetime
      DateTime.parse(var)
    else
      var
    end
  end
end
# END
