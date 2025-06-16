module DataFields
  class Decimal < Base
    data_attribute :value, :float
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end