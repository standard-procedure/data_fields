module DataFields
  class Number < Base
    data_attribute :value, :integer
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
