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
    it "formats a number" do
      expect_formatted(1234567.89).to eq space_to_nbsp("1 234 567.89")
    end

    it "applies default options" do
      Formatting.defaults = { round: 3 }
      expect_formatted(12.3456789).to eq "12.346"
    end

    context "thousands separator" do
      context "with I18n" do
        let(:i18n) { stub_const("I18n", double) }

        it "uses I18n.t('number.format.delimiter') if present" do
          allow(i18n).to receive(:t).with(:separator, instance_of(Hash))
          expect(i18n).to receive(:t).
            with(:delimiter, scope: "number.format", default: space_to_nbsp(" ")).
            and_return(";")
          expect_formatted(1234).to include "1;234"
        end
      end

      context "without I18n" do
        it "defaults to a non-breaking space" do
          expect_formatted(1234).to include space_to_nbsp("1 234")
          expect_formatted(1234).not_to include "1 234"
        end
      end

      it "can be customized" do
        expect_formatted(1234, thousands_separator: ":").to include "1:234"
      end
    end

    context "decimal separator" do
      context "with I18n" do
        let(:i18n) { stub_const("I18n", double) }

        it "uses I18n.t('number.format.separator') if present" do
          allow(i18n).to receive(:t).with(:delimiter, instance_of(Hash))
          expect(i18n).to receive(:t).with(:separator, scope: "number.format", default: ".").and_return(";")
          expect_formatted(1.2).to eq "1;20"
        end
      end

      context "without I18n" do
        it "defaults to ." do
          expect_formatted(1.2).to eq "1.20"
        end
      end

      it "can be customized" do
        expect_formatted(1.2, decimal_separator: ":").to eq "1:20"
      end
    end

    context "rounding" do
      it "rounds to 2 decimals by defaults" do
        expect_formatted(12.3456789).to eq "12.35"
      end

      it "rounds to the given number of decimals" do
        expect_formatted(12.3456789, round: 3).to eq "12.346"
      end

      it "doesn't round if given false" do
        expect_formatted(12.3456789, round: false).to eq "12.3456789"
      end
    end

    context "blanking when zero" do
      it "does not happen by default" do
        expect_formatted(0).to eq "0.00"
      end

      it "can be enforced" do
        expect_formatted(0, blank_when_zero: true).to eq ""
      end
    end


    context "minimum number of decimals" do
      it "defaults to two decimals" do
        expect_formatted(12).to eq "12.00"
        expect_formatted(12.3).to eq "12.30"
      end

      it "can be enforced" do
        expect_formatted(12.3, min_decimals: 3).to eq "12.300"
      end

      it "is not enforced if given false" do
        expect_formatted(0, min_decimals: false).to eq "0"
        expect_formatted(12, min_decimals: false).to eq "12"
        expect_formatted(0.0, min_decimals: false).to eq "0.0"
        expect_formatted(12.0, min_decimals: false).to eq "12.0"
        expect_formatted(12.3, min_decimals: false).to eq "12.3"
      end
    end

    context "explicit sign" do
      it "is not included by default" do
        expect_formatted(1).to eq "1.00"
        expect_formatted(0).to eq "0.00"
        expect_formatted(-1).to eq "-1.00"
      end

      it "never shows 0 as negative" do
        expect_formatted(-0.0).to eq "0.00"
      end

      it "can be enforced" do
        expect_formatted(1, explicit_sign: true).to eq "+1.00"
        expect_formatted(0, explicit_sign: true).to eq "0.00"
        expect_formatted(-1, explicit_sign: true).to eq "-1.00"
      end
    end
  end

  def expect_formatted(value, opts = {})
    expect(Formatting.format_number(value, opts))
  end
end
