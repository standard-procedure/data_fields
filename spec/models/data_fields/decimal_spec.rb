require "rails_helper"

RSpec.describe DataFields::Decimal, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "renders the float value as string" do
      field = described_class.new(value: 42.5)
      expect(field.to_html).to eq("42.5")
    end

    it "returns empty string if value is nil" do
      field = described_class.new(value: nil)
      expect(field.to_html).to eq("")
    end
  end
end
