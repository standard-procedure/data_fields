module DataFields
  class DateTime < Base
    data_attribute :value, :datetime
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end