module DataFields
  class Checkbox < Base
    has_attribute :value, :boolean
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
    def to_html = value? ? "☑️" : "🆇"
  end
end
