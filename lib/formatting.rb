require "formatting/version"

module Formatting
  NON_BREAKING_SPACE = "\xc2\xa0"
  THOUSANDS_SEPARATOR = NON_BREAKING_SPACE
  DECIMAL_SEPARATOR = "."

  def self.format_number(number, opts = {})
    thousands_separator = THOUSANDS_SEPARATOR
    decimal_separator = DECIMAL_SEPARATOR
    round = opts.fetch(:round, nil)

    if round
      number = number.round(round)
    end

    integer, decimals = number.to_s.split(".")

    integer.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{thousands_separator}")
    [integer, decimals].join(decimal_separator)
  end
end
