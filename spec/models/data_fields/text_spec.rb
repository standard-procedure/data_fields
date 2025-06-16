require "rails_helper"

RSpec.describe DataFields::Text, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Text Field", container: container)
      expect(field).to be_valid
    end

    context "when required and data_value?" do
      it "is valid with non-empty value" do
        field = described_class.new(name: "Comment", data_field_type: :data_value, required: true, value: "Some comment", container: container)
        expect(field).to be_valid
      end
    end
  end

  describe "#to_html" do
    it "returns the value as a string" do
      field = described_class.new(value: "Display this", container: container)
      expect(field.to_html).to eq("Display this")
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Text Field", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))
      expect(field.copy_into(collection)).to eq(:copied)
    end
  end
end
