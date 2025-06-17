require "rails_helper"

RSpec.describe DataFields::Time, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "returns the value as a string" do
      time = Time.zone.parse("14:30")
      field = described_class.new(value: time, container: container)
      expect(field.to_html).to eq(time.to_s)
    end
  end
end
