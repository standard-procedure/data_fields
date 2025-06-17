require "rails_helper"

RSpec.describe DataFields::Signature, type: :model do
  it_behaves_like "a field"

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
end
