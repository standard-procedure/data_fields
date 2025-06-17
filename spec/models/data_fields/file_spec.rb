require "rails_helper"

RSpec.describe DataFields::File, type: :model do
  it_behaves_like "a field"

  it "must be attached if the field is required" do
    field = described_class.create! name: "Some file", container: MyContainer.create, required: true

    field.validate

    expect(field.errors).to include :value
  end
end
