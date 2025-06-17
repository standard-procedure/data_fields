module DataFields
  class Decimal < Field
    has_attribute :value, :float
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
