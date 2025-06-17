require "rails_helper"

RSpec.describe DataFields::Image, type: :model do
  it_behaves_like "a field"

  it "must be attached if the field is required" do
    field = described_class.create! name: "Picture this", container: MyContainer.create, required: true

    field.validate

    expect(field.errors).to include :value
  end

  it "must be an image" do
    field = described_class.create! name: "Picture this", container: MyContainer.create

    field.value.attach fixture_file_upload("policy.docx")
    field.validate

    expect(field.errors).to include :value
  end

  describe "#to_s" do
    it "returns filename if attached" do
      field = described_class.new value: fixture_file_upload("logo.png")

      expect(field.to_s).to eq("logo.png")
    end
  end

  describe "#to_html" do
    it "returns an HTML img tag for the image" do
      field = described_class.new value: fixture_file_upload("logo.png")

      allow(field.value).to receive(:url).and_return("/rails/active_storage/blobs/logo.png")
      expect(field.to_html).to eq("<img src='/rails/active_storage/blobs/logo.png' alt='logo.png'>")
    end
  end
end
