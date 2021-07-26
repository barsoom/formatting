# frozen_string_literal: true

require "attr_extras"

module Formatting
  module Percent
    def format_percent(number, opts = {})
      format_string = opts.fetch(:format) { default_percent_format_string }
      formatted_number = Formatting.format_number(number, opts)
      format_string.gsub("<number>", formatted_number)
    end

    private

    # http://en.wikipedia.org/wiki/Percent_sign#Spacing
    # Rails i18n doesn't have a conventional format string for this.
    def default_percent_format_string
      locale = defined?(I18n) && I18n.locale

      case locale
      when :sv, :fi, :fr, :de
        "<number>#{Formatting::NON_BREAKING_SPACE}%"
      else
        "<number>%"
      end
    end
  end
end
