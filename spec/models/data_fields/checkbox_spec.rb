require "rails_helper"

RSpec.describe DataFields::Checkbox, type: :model do
  it_behaves_like "a field"

  describe "#value" do
    it "accepts form field values" do
      field = described_class.create container: MyContainer.create, name: "Tick me", data_field_type: "data_value"

      field.update! value: "1"

      expect(field.value).to be true

      field.update! value: "0"

      expect(field.value).to be false
    end
  end

  describe "#to_html" do
    it "renders ☑️ if value is true" do
      field = described_class.new(value: true)
      expect(field.to_html).to eq("☑️")
    end

    it "renders 🆇 if value is false" do
      field = described_class.new(value: false)
      expect(field.to_html).to eq("🆇")
    end
  end
end
