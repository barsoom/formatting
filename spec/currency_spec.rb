require "spec_helper"

describe Formatting::Currency do
  it "can be included as a module" do
    object = Object.new
    object.extend Formatting::Currency
    expect(object).to respond_to(:format_currency)
  end
end

describe Formatting do
  describe ".format_currency" do
    it "formats numbers" do
      expect_formatted(1234.567).to eq space_to_nbsp("1 234.567")
    end
  end

  def expect_formatted(value, opts = {})
    expect(Formatting.format_currency(value, opts))
  end
end
