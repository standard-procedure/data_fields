require "rails_helper"

RSpec.describe DataFields::Signature, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Signature Field", container: container)
      expect(field).to be_valid
    end
  end

  describe "#to_html" do
    it "returns an img tag if value is present" do
      value = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA"
      field = described_class.new(value: value)
      expect(field.to_html).to include("img")
      expect(field.to_html).to include(value)
    end

    it "returns an empty string if value is blank" do
      field = described_class.new(value: "")
      expect(field.to_html).to eq("")
    end
  end

  describe "#file_extension" do
    it "returns 'png' if value is blank" do
      field = described_class.new(value: "")
      expect(field.file_extension).to eq("png")
    end

    it "returns the extension from base64 data" do
      field = described_class.new(value: "data:image/jpeg;base64,somebase64data")
      expect(field.file_extension).to eq("jpeg")
    end
  end

  describe "#image_data" do
    it "returns empty string if value is blank" do
      field = described_class.new(value: "")
      expect(field.image_data).to eq("")
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Signature", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))
      expect(field.copy_into(collection)).to eq(:copied)
    end
  end
end
