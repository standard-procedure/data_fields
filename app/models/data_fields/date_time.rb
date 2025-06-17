module DataFields
  class DateTime < Field
    has_attribute :value, :datetime
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
