require "rails_helper"

RSpec.describe DataFields::Number, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Enter a Number", container: container)
      expect(field).to be_valid
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original Number", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))

      result = field.copy_into(collection)
      expect(result).to eq(:copied)
    end
  end

  describe "data_field_type enum" do
    it "includes :data_value, :form_field_definition, :metadata_field_definition, and :archived" do
      expect(described_class.data_field_types.keys).to include("data_value", "form_field_definition", "metadata_field_definition", "archived")
    end
  end
end
