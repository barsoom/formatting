require "spec_helper"

describe Formatting::Number do
  it "can be included as a module" do
    object = Object.new
    object.extend Formatting::Number
    expect(object).to respond_to(:format_number)
  end
end

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

    context "blanking when zero" do
      it "does not happen by default" do
        expect_formatted(0).to eq "0.0"
      end

      it "can be enforced" do
        expect_formatted(0, blank_when_zero: true).to eq ""
      end
    end


    context "minimum number of decimals" do
      it "is not enforced by default" do
        expect_formatted(12).to eq "12.0"
        expect_formatted(12.3).to eq "12.3"
      end

      it "can be enforced" do
        expect_formatted(12.3, min_decimals: 2).to eq "12.30"
      end
    end

    context "explicit sign" do
      it "is not included by default" do
        expect_formatted(1).to eq "1.0"
        expect_formatted(0).to eq "0.0"
        expect_formatted(-1).to eq "-1.0"
      end

      it "never shows 0 as negative" do
        expect_formatted(-0.0).to eq "0.0"
      end

      it "can be enforced" do
        expect_formatted(1, explicit_sign: true).to eq "+1.0"
        expect_formatted(0, explicit_sign: true).to eq "0.0"
        expect_formatted(-1, explicit_sign: true).to eq "-1.0"
      end
    end
  end
end
