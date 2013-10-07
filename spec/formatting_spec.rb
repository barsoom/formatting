require "formatting"

describe Formatting do
  describe ".format_number" do
    it "groups thousands" do
      expect_formatted(1234567.89).to eq space_to_nbsp("1 234 567.89")
    end

    context "rounding" do
      it "doesn't round by default" do
        expect_formatted(12.3456789).to eq "12.3456789"
      end

      it "rounds to the given number of decimals" do
        expect_formatted(12.3456789, round: 2).to eq "12.35"
      end
    end

    def expect_formatted(value, opts = {})
      expect(Formatting.format_number(value, opts))
    end

    def space_to_nbsp(value)
      value.gsub(" ", "\xc2\xa0")
    end
  end
end

# rounding (default/custom)
# including module
