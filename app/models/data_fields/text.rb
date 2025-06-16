module DataFields
  class Text < Base
    data_attribute :value, :string, default: ""
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
  end
end
