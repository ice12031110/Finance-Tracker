# frozen_string_literal: true

class Forms::TextFieldComponent < ViewComponent::Base
  attr_reader :form, :attribute, :label, :options, :required, :classes, :coustom_error_message

  def initialize(**args)
    @form = args.fetch(:form, "")
    @attribute = args.fetch(:attribute)
    @label = args.fetch(:label, "")
    @options = args.fetch(:options, {})
    @required = args.fetch(:required, "")
    @classes = args.fetch(:classes, "")
    @coustom_error_message = args.fetch(:coustom_error_message, "")
  end

  def error_message
    return coustom_error_message if form.blank?

    form.object.errors[attribute].uniq.join(", ") if form.object.errors[attribute].present?
  end

  def error_class
    return "" if  coustom_error_message.blank? && form.blank?

    form&.object&.errors[attribute].any? ? "border border-nkic-error" : ""
  end
end
