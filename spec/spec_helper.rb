require "formatting"

module Helpers
  def space_to_nbsp(value)
    value.gsub(" ", Formatting::NON_BREAKING_SPACE)
  end
end

RSpec.configure do |config|
  config.include Helpers

  config.example_status_persistence_file_path = ".rspec_results"
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand config.seed
end
