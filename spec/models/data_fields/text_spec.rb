require "rails_helper"

RSpec.describe DataFields::Text, type: :model do
  it_behaves_like "a field"

  describe "#to_html" do
    it "returns the value as a string" do
      field = described_class.new value: "Display this"

      expect(field.to_html).to eq "Display this"
    end
  end
end
