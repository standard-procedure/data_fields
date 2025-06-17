module DataFields
  class Number < Field
    has_attribute :value, :integer
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
