require "rails_helper"

RSpec.describe DataFields::MultiSelect, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }
  let(:options) do
    {
      "opt1" => "Option 1",
      "opt2" => "Option 2",
      "opt3" => "Option 3"
    }
  end

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Choose Options", container: container)
      expect(field).to be_valid
    end

    context "when required and data_value?" do
      it "is valid if all selected values are in options" do
        field = described_class.new(name: "Choices", container: container, data_field_type: :data_value)
        field.required = true
        field.options = options
        field.value = ["opt1", "opt2"]
        expect(field).to be_valid
      end
    end
  end

  describe "#value" do
    it "returns an array of selected values without blanks" do
      field = described_class.new
      field.value = ["opt1", "", nil, "opt2"]
      expect(field.value).to eq(["opt1", "opt2"])
    end
  end

  describe "#label / #labels" do
    it "returns label(s) for the selected values" do
      field = described_class.new
      field.options = options
      field.value = ["opt2", "opt1"]
      expect(field.label).to eq(["Option 2", "Option 1"])
      expect(field.labels).to eq(field.label)
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original MultiSelect", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))

      result = field.copy_into(collection)
      expect(result).to eq(:copied)
    end
  end
end
