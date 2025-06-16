require "rails_helper"

RSpec.describe DataFields::Checkbox, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "")
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end
  end
end
