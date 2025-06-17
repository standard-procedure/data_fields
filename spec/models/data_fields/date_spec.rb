require "rails_helper"

RSpec.describe DataFields::Date, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "renders the date value as a string" do
      date = Date.new(2025, 6, 16)
      field = described_class.new(value: date)
      expect(field.to_html).to eq(date.to_s)
    end

    it "returns empty string if value is nil" do
      field = described_class.new(value: nil)
      expect(field.to_html).to eq("")
    end
  end
end
