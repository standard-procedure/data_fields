require "rails_helper"

RSpec.describe DataFields::Url, type: :model do
  it_behaves_like "a field"

  it "must be a URL" do
    field = described_class.create! name: "Address", container: MyContainer.create

    field.value = "not a URL"
    field.validate
    expect(field.errors).to include :value
  end

  describe "#to_html" do
    it "returns the value as a string" do
      field = described_class.new value: "https://example.com"

      expect(field.to_html).to eq("https://example.com")
    end
  end
end
