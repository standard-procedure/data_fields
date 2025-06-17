module DataFields
  class Date < Base
    has_attribute :value, :date
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
