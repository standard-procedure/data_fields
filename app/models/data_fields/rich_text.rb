module DataFields
  class RichText < Base
    has_rich_text :value

    def to_html = value.to_s
  end
end
