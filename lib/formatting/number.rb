require "attr_extras"

module Formatting
  module Number
    def format_number(number, opts = {})
      FormatNumber.new(number, opts).format
    end
  end

  class FormatNumber
    attr_private :input_number,
      :thousands_separator, :decimal_separator,
      :round, :min_decimals, :decimals_on_integers, :explicit_sign, :blank_when_zero

    def initialize(input_number, opts)
      @input_number = input_number

      @thousands_separator  = opts.fetch(:thousands_separator) { default_thousands_separator }
      @decimal_separator    = opts.fetch(:decimal_separator) { default_decimal_separator }
      @round                = opts.fetch(:round, 2)
      @min_decimals         = opts.fetch(:min_decimals, 2)
      @decimals_on_integers = opts.fetch(:decimals_on_integers, true)
      @explicit_sign        = opts.fetch(:explicit_sign, false)
      @blank_when_zero      = opts.fetch(:blank_when_zero, false)
    end

    def format
      number = input_number

      has_decimals = number.to_s.include?(".")

      if blank_when_zero
        return "" if number.zero?
      end

      # Avoid negative zero.
      number = 0 if number.zero?

      if round
        number = number.round(round) if has_decimals
      end

      integer, decimals = number.to_s.split(".")

      # Separate groups by thousands separator.
      integer.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{thousands_separator}")

      if explicit_sign
        integer = "+#{integer}" if number > 0
      end

      if min_decimals && (has_decimals || decimals_on_integers)
        decimals ||= "0"
        decimals = decimals.ljust(min_decimals, "0")
      end

      [integer, decimals].compact.join(decimal_separator)
    end

    private

    def default_thousands_separator
      t_format(:delimiter, NON_BREAKING_SPACE)
    end

    def default_decimal_separator
      t_format(:separator, ".")
    end

    def t_format(key, default)
      if defined?(I18n)
        I18n.t(key, scope: "number.format", default: default)
      else
        default
      end
    end
  end
end
