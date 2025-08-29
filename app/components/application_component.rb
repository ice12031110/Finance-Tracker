# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include ActiveModel::AttributeAssignment

  def initialize(**accessors)
    super()
    assign_attributes(accessors || {})
  end

  def translate(key, **options)
    options[:scope] = [ :view_component ]
    options[:scope] << self.class.name.underscore unless key.start_with?(".")
    super
  end

  alias t translate
end
