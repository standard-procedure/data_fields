require "rails_helper"

RSpec.describe DataFields::Decimal, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Price", container: container)
      expect(field).to be_valid
    end
  end

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

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))

      result = field.copy_into(collection)
      expect(result).to eq(:copied)
    end
  end
end
