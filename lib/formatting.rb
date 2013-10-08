require "formatting/version"
require "formatting/number"
require "formatting/currency"

module Formatting
  NON_BREAKING_SPACE = "\xc2\xa0"

  def self.defaults=(opts)
    @defaults = opts
  end

  def self.defaults
    @defaults
  end

  self.defaults = {}

  extend Number
  extend Currency
end
