# encoding: utf-8
# ^ so NON_BREAKING_SPACE is treated as UTF-8 in Ruby 1.9.

require "formatting/version"
require "formatting/number"
require "formatting/currency"
require "formatting/percent"

module Formatting
  NON_BREAKING_SPACE = "\xc2\xa0"

  extend Number
  extend Currency
  extend Percent
end
