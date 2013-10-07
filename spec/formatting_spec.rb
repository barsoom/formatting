require "formatting"

describe Formatting do
  describe ".format_number" do
    it "formats" do
      expect_formatted(1234567.89).to eq space_to_nbsp("1 234 567.89")
    end

    def expect_formatted(value)
      expect(Formatting.format_number(value))
    end

    def space_to_nbsp(value)
      value.gsub(" ", "\xc2\xa0")
    end
  end
end

# rounding (default/custom)
# including module
