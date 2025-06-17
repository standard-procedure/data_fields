module DataFields
  class Time < Base
    has_attribute :value, :time
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
