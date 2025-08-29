# frozen_string_literal: true

class Forms::SelectComponent < ApplicationComponent
  attr_accessor :name, :label, :choices, :selected, :options, :html_options, :hint, :container_classes, :error, :required

  def initialize(**args)
    super

    @required = args.fetch(:required, "")
    @options = args.fetch(:options, {})
    @html_options = args.fetch(:html_options, {})
    @html_options.merge!('data-controller': "tom-select")
  end
end
