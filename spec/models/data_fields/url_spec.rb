require "rails_helper"

RSpec.describe DataFields::Url, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Website", container: container)
      expect(field).to be_valid
    end

    context "when required and data_value?" do
      it "is valid with a proper URL" do
        field = described_class.new(name: "Website", data_field_type: :data_value, required: true, value: "https://example.com", container: container)
        expect(field).to be_valid
      end
    end
  end

  describe "normalization" do
    it "strips and downcases the value" do
      field = described_class.new(name: "Website", data_field_type: :data_value, required: true, value: "  HTTPS://EXAMPLE.COM/  ", container: container)
      field.validate
      expect(field.value).to eq("https://example.com/")
    end
  end

  describe "#to_html" do
    it "returns the value as a string" do
      field = described_class.new(value: "https://example.com", container: container)
      expect(field.to_html).to eq("https://example.com")
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original URL", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))
      expect(field.copy_into(collection)).to eq(:copied)
    end
  end
end
