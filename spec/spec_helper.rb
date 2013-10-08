require "formatting"

module Helpers
  def expect_formatted(value, opts = {})
    expect(Formatting.format_number(value, opts))
  end

  def space_to_nbsp(value)
    value.gsub(" ", "\xc2\xa0")
  end
end

RSpec.configure do |config|
  config.include Helpers
end
