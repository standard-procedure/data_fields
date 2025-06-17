require "rails_helper"

RSpec.describe DataFields::Image, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Upload Image", container: container)
      expect(field).to be_valid
    end
  end

  describe "#to_s" do
    it "returns filename if attached" do
      field = described_class.new(name: "Image Field", container: container)
      file = fixture_file_upload(Rails.root.join("/logo.png"), "image/png")
      field.value.attach(file)
      expect(field.to_s).to eq("logo.png")
    end
  end

  describe "#to_html" do
    it "returns an HTML img tag for the image" do
      field = described_class.new(name: "Image Field", container: container)
      file = fixture_file_upload(Rails.root.join("/logo.png"), "image/png")
      field.value.attach(file)

      allow(field.value).to receive(:url).and_return("/rails/active_storage/blobs/logo.png")
      expect(field.to_html).to eq("<img src='/rails/active_storage/blobs/logo.png' alt='logo.png'>")
    end
  end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original Image", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))

      result = field.copy_into(collection)
      expect(result).to eq(:copied)
    end
  end
end
