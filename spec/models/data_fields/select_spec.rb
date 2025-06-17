require "rails_helper"

RSpec.describe DataFields::Select, type: :model do
  it_behaves_like "a field"

  it "only accepts values from its legal set of options" do
    field = described_class.create name: "Select", container: MyContainer.create, data_field_type: "data_value", options: {one: "One", two: "Two"}

    field.value = "three"
    field.validate

    expect(field.errors).to include :value
  end
end
