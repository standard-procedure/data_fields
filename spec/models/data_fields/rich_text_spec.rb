require "rails_helper"

RSpec.describe DataFields::RichText, type: :model do
  it_behaves_like "a field", check_required: false

  describe "#to_html" do
    it "returns the rendered HTML of the rich text" do
      field = described_class.new name: "Info", value: "Some <b>rich</b> content"
      expected_html = "<div class=\"trix-content\">\n  Some <b>rich</b> content\n</div>\n"

      expect(field.to_html).to eq expected_html
    end
  end
end
