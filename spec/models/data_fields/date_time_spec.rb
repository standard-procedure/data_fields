require "rails_helper"

RSpec.describe DataFields::DateTime, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "renders the datetime value as a string" do
      time = Time.utc(2025, 6, 16, 12, 0)
      field = described_class.new(value: time)
      expect(field.to_html).to eq(time.to_s)
    end

    it "returns empty string if value is nil" do
      field = described_class.new(value: nil)
      expect(field.to_html).to eq("")
    end
  end
end
