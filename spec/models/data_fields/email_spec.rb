require "rails_helper"

RSpec.describe DataFields::Email, type: :model do
  it_behaves_like "a field"

  it "only accepts email addresses" do
    field = described_class.create! name: "Email", container: MyContainer.create

    field.value = "not an email address"
    field.validate

    expect(field.errors).to include :value
  end

  describe "#to_html" do
    it "renders the email string" do
      field = described_class.new(value: "example@domain.com")
      expect(field.to_html).to eq("example@domain.com")
    end

    it "returns empty string if value is nil" do
      field = described_class.new(value: nil)
      expect(field.to_html).to eq("")
    end
  end
end
