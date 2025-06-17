require "rails_helper"

RSpec.describe DataFields::Select, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new name: ""

      field.validate

      expect(field.errors).to include :name
    end

    it "only accepts values from its legal set of options" do
      field = described_class.create name: "Select", container: MyContainer.create, data_field_type: "data_value", options: {one: "One", two: "Two"}

      field.value = "three"
      field.validate

      expect(field.errors).to include :value
    end

    it "must have a value if marked as required" do
      field = described_class.create name: "Select", container: MyContainer.create, data_field_type: "data_value", options: {one: "One", two: "Two"}, required: true

      field.value = ""
      field.validate

      expect(field.errors).to include :value
    end
  end
end
