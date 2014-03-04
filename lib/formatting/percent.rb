# http://en.wikipedia.org/wiki/Percent_sign#Spacing

require "attr_extras"

module Formatting
  module Percent
    def format_percent(number, opts = {})
      formatted_number = Formatting.format_number(number, opts)
      "#{formatted_number}%"
    end
  end
end
