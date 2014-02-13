require "formatting"

module Helpers
  def space_to_nbsp(value)
    value.gsub(" ", Formatting::NON_BREAKING_SPACE)
  end
end

RSpec.configure do |config|
  config.include Helpers
end
