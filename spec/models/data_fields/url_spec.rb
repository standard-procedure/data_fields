require "rails_helper"

RSpec.describe DataFields::Url, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "returns the value as a string" do
      field = described_class.new value: "https://example.com"

      expect(field.to_html).to eq("https://example.com")
    end
  end
end
