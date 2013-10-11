module Formatting
  module Number
    def format_number(number, opts = {})
      opts = Formatting.defaults.merge(opts)

      thousands_separator = opts.fetch(:thousands_separator, NON_BREAKING_SPACE)
      decimal_separator   = opts.fetch(:decimal_separator) { default_decimal_separator }
      round           = opts.fetch(:round, 2)
      min_decimals    = opts.fetch(:min_decimals, 2)
      explicit_sign   = opts.fetch(:explicit_sign, false)
      blank_when_zero = opts.fetch(:blank_when_zero, false)

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

      integer.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{thousands_separator}")

      if explicit_sign
        integer = "+#{integer}" if number > 0
      end

      if min_decimals
        decimals ||= "0"
        decimals = decimals.ljust(min_decimals, "0")
      end

      [integer, decimals].compact.join(decimal_separator)
    end

    private

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
