require "rails_helper"

RSpec.describe DataFields::MultiSelect, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "")

      field.validate

      expect(field.errors).to include :name
    end
  end

  describe "#value" do
    it "only accepts values from its legal set of options" do
      field = described_class.create name: "Select", container: MyContainer.create, data_field_type: "data_value", options: {one: "One", two: "Two"}

      field.value = ["one", "three"]
      field.validate

      expect(field.errors).to include :value
    end

    it "must have a value if marked as required" do
      field = described_class.create name: "Select", container: MyContainer.create, data_field_type: "data_value", options: {one: "One", two: "Two"}, required: true

      field.value = ""
      field.validate

      expect(field.errors).to include :value
    end

    it "returns an array of selected values without blanks" do
      field = described_class.new options: {"1" => "Option 1", "2" => "Option 2", "3" => "Option 3"}, value: ["1", "", nil, "3"]

      expect(field.value).to eq(["1", "3"])
    end
  end

  describe "#label" do
    it "returns an array of selected labels without blanks" do
      field = described_class.new options: {"1" => "Option 1", "2" => "Option 2", "3" => "Option 3"}, value: ["1", "", nil, "3"]

      expect(field.label).to eq(["Option 1", "Option 3"])
    end
  end
end
