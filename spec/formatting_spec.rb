require "spec_helper"

describe Formatting do
  describe "defaults" do
    it "starts out as an empty hash" do
      expect(Formatting.defaults).to eq({})
    end

    it "can get and set them" do
      Formatting.defaults = { hello: "world" }
      expect(Formatting.defaults).to eq({ hello: "world" })
    end
  end
end
