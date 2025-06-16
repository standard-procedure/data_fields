require "rails_helper"

RSpec.describe DataFields::Select, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Choose Option", container: container)
      expect(field).to be_valid
    end

    context "when required and data_value?" do
      it "is valid if value is in options" do
        field = described_class.new(name: "Pick one", container: container, data_field_type: :data_value, required: true, value: "a")
        field.options = { "a" => "Alpha", "b" => "Beta" }
        expect(field).to be_valid
      end
    end
  end

  describe "#label" do
    it "returns the label from options" do
      field = described_class.new(value: "x")
      field.options = { "x" => "Option X", "y" => "Option Y" }
      expect(field.label).to eq("Option X")
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

  describe "data_field_type enum" do
    it "includes all expected types" do
      expect(described_class.data_field_types.keys).to include("data_value", "form_field_definition", "metadata_field_definition", "archived")
    end
  end
end
