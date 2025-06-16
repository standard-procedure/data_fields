require "rails_helper"

RSpec.describe DataFields::RichText, type: :model do
  let(:container) { MyContainer.create!(name: "Test Container") }

  describe "validations" do
    it "is invalid without a name" do
      field = described_class.new(name: "", container: container)
      expect(field).not_to be_valid
      expect(field.errors[:name]).to include("can't be blank")
    end

    it "is valid with a name and container" do
      field = described_class.new(name: "Description", container: container)
      expect(field).to be_valid
    end
  end

  describe "#to_html" do
  it "returns the rendered HTML of the rich text" do
    field = described_class.new(name: "Info", container: container)
    field.value = "Some <b>rich</b> content"
    expected_html = "<div class=\"trix-content\">\n  Some <b>rich</b> content\n</div>\n"
    expect(field.to_html).to eq(expected_html)
  end
end

  describe "#copy_into" do
    let(:collection) { double("collection") }

    it "copies itself into the collection" do
      field = described_class.new(name: "Original RichText", data_field_type: :form_field_definition)
      allow(collection).to receive(:where).with(copied_from: field).and_return(double(first_or_create!: :copied))

      result = field.copy_into(collection)
      expect(result).to eq(:copied)
    end
  end
end
