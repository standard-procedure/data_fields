module DataFields
  class File < Base
    has_one_attached :value
    validate :file_is_attached, if: -> { data_value? && required? }, on: :update

    def to_s = value.filename.to_s

    def to_html = File.link_tag_for(value, text: to_s)

    def self.link_tag_for(attachment, text: "") = "<a href='#{attachment.url}'>#{text}</a>"

    private def file_is_attached
      errors.add(:value, :blank) unless value.attached?
    end
  end
end