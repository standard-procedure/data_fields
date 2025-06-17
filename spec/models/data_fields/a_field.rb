RSpec.shared_examples "a field" do |check_required: true|
  it "is invalid without a name" do
    field = described_class.new name: ""

    field.validate

    expect(field.errors).to include :name
  end

  if check_required
    it "is invalid if a data_value and required with a nil value" do
      field = described_class.create! name: "A field", container: MyContainer.create, required: true

      field.value = nil
      field.validate

      expect(field.errors).to include :value
    end
  end
end
