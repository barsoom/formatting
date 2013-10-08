require "formatting/version"
require "formatting/number"
require "formatting/currency"

module Formatting
  NON_BREAKING_SPACE = "\xc2\xa0"

  class << self
    attr_accessor :defaults
  end

  self.defaults = {}

  extend Number
  extend Currency
end
