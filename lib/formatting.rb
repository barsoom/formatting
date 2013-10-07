require "formatting/version"

module Formatting
  module Number
    NON_BREAKING_SPACE = "\xc2\xa0"
    THOUSANDS_SEPARATOR = NON_BREAKING_SPACE
    DECIMAL_SEPARATOR = "."

    def format_number(number, opts = {})
      thousands_separator = THOUSANDS_SEPARATOR
      decimal_separator = DECIMAL_SEPARATOR

      round           = opts.fetch(:round, nil)
      min_decimals    = opts.fetch(:min_decimals, nil)
      explicit_sign   = opts.fetch(:explicit_sign, false)
      blank_when_zero = opts.fetch(:blank_when_zero, false)

      if blank_when_zero
        return "" if number.zero?
      end

      # Avoid negative zero.
      number = 0 if number.zero?

      if round
        number = number.round(round)
      end

      integer, decimals = number.to_s.split(".")
      decimals ||= "0"

      integer.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{thousands_separator}")

      if explicit_sign
        integer = "+#{integer}" if number > 0
      end

      if min_decimals
        decimals = decimals.ljust(min_decimals, "0")
      end

      [integer, decimals].join(decimal_separator)
    end
  end

  extend Number
end
