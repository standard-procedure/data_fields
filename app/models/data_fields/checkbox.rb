module DataFields
  class Checkbox < Field
    has_attribute :value, :boolean

    def to_html = value? ? "☑️" : "🆇"
  end
end
