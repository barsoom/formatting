require "formatting/version"

module Formatting
  NON_BREAKING_SPACE = "\xc2\xa0"

  require "formatting/number"
  require "formatting/currency"

  extend Number
  extend Currency
end
