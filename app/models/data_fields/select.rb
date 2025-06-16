module DataFields
  class Select < Base
    include DataFields::HasOptions
    data_attribute :value, :string
    validate :selected_value_is_legal, if: -> { data_value? && required? }, on: :update

    def label = options[value.to_s]

    private def selected_value_is_legal
      errors.add :value, :invalid if required? && !options.key?(value)
    end
  end
end
