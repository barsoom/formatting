# frozen_string_literal: true

require "spec_helper"

RSpec.describe Formatting::Percent do
  it "can be included as a module" do
    object = Object.new
    object.extend Formatting::Percent
    expect(object).to respond_to(:format_percent)
  end
end

RSpec.describe Formatting, ".format_percent" do
  it "formats a number" do
    expect_formatted(1.2).to eq "1.20%"
  end

  it "passes on number formatting options" do
    expect_formatted(1.567, round: 1).to include "1.6"
  end

  context "format string option" do
    it "is used if provided" do
      expect_formatted(1, format: "%<number>%").to eq "%1.00%"
    end

    context "if I18n.locale is available" do
      let(:i18n) { stub_const("I18n", double) }

      it "defaults sensibly for some locales that require spacing the sign" do
        allow(i18n).to receive(:locale).and_return(:sv)
        expect_formatted(1).to eq space_to_nbsp("1.00 %")
      end
    end
  end

  def expect_formatted(number, opts = {})
    expect(Formatting.format_percent(number, opts))
  end
end
