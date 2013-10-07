require "formatting"

describe Formatting do
  describe ".format_number" do
    it "formats" do
      expect_formatted(1234567.89).to eq "1,234,567.89"
    end

    def expect_formatted(value)
      expect(Formatting.format_number(value))
    end
  end
end

# rounding (default/custom)
# including module
