require "spec_helper"

describe Formatting::Percent do
  it "can be included as a module" do
    object = Object.new
    object.extend Formatting::Percent
    expect(object).to respond_to(:format_percent)
  end
end

describe Formatting, ".format_percent" do
  it "formats a number" do
    expect_formatted(1.2).to eq "1.20%"
  end

  it "passes on number formatting options" do
    expect_formatted(1.567, round: 2).to include "1.57"
  end

  def expect_formatted(number, opts = {})
    expect(Formatting.format_percent(number, opts))
  end
end
