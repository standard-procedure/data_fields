module DataFields
  class Image < File
    include ImageToHtml
    validate :file_is_image, if: -> { data_value? && required? }, on: :update

    def to_html = image_tag_for(value, alt: to_s)

    private def file_is_image
      errors.add :value, :invalid if value.attached? && !value.blob.image?
    end
  end
end
