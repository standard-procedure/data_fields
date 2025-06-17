module DataFields
  class RichText < Field
    has_rich_text :value

    def to_html = value.to_s
  end
end
