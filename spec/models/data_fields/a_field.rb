RSpec.shared_examples "a field" do
  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new name: ""

      field.validate

      expect(field.errors).to include :name
    end
  end
end
