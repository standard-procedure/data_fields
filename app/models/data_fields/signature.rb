module DataFields
  class Signature < Base
    data_attribute :value, default: ""
    validate :signature_present_if_required, if: -> { data_value? && required? }, on: :update

    def to_html = value.blank? ? "" : "<img src=\"#{value}\" alt=\"Signature\" style=\"max-width: 100%; height: auto;\" />".html_safe

    def file_extension = value.blank? ? "png" : value.match(%r{\Adata:image/(\w+);base64,(.+)\z})[1]

    def image_data = value.blank? ? "" : Base64.decode64(value.match(%r{\Adata:image/(\w+);base64,(.+)\z})[2])

    private def signature_present_if_required
      errors.add(:value, :blank) if required? && value.blank?
    end
  end
end