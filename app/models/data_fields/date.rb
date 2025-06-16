module DataFields
  class Date < Base
    data_attribute :value, :date
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
