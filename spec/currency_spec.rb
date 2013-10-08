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
    let(:item) { double(price: 123.45) }

    it "formats numbers" do
      expect_formatted(item, 1234.56).to include space_to_nbsp("1 234.56")
    end

    it "passes on number formatting options" do
      expect_formatted(item, 1234.567, round: 2).to include space_to_nbsp("1 234.57")
    end

    context "currency option" do
      it "is added if provided" do
        expect_formatted(item, 1234.56, currency: "XYZ").to eq space_to_nbsp("1 234.56 XYZ")
      end

      it "may be nil" do
        expect_formatted(item, 1234.56).to eq space_to_nbsp("1 234.56")
      end
    end

    context "format string option" do
      it "is used if provided" do
        expect_formatted(item, 123, format: "C: <currency> A: <amount>", currency: "XYZ").
          to eq space_to_nbsp("C: XYZ A: 123.0")
      end

      it "will have spaces turned into non-breaking spaces" do
        expect_actual = expect_formatted(item, 123, format: "<amount> <currency>", currency: "XYZ")
        expect_actual.to eq space_to_nbsp("123.0 XYZ")
        expect_actual.not_to eq "123.0 XYZ"
      end

      it "is stripped" do
        expect_formatted(item, 123, format: "<amount> <currency>", currency: nil).
          to eq space_to_nbsp("123.0")
      end
    end
  end

  def expect_formatted(record, value, opts = {})
    expect(Formatting.format_currency(record, value, opts))
  end
end
