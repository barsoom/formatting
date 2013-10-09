require "formatting"

module Helpers
  def space_to_nbsp(value)
    value.gsub(" ", "\xc2\xa0")
  end
end

RSpec.configure do |config|
  config.include Helpers

  config.before do
    Formatting.defaults = {}
  end
end
