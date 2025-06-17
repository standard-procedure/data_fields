module DataFields
  class Select < Field
    include DataFields::HasOptions
    has_attribute :value, :string
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
    validate :selected_value_is_legal, if: -> { data_value? }, on: :update

    def label = options[value.to_s]

    private def selected_value_is_legal
      errors.add :value, :invalid if value.present? && !options.key?(value.to_s)
    end
  end
end
