module DataFields
  class MultiSelect < Field
    include DataFields::HasOptions
    has_attribute :selected_values, default: []
    validate :selected_values_are_legal, if: -> { data_value? && required? }, on: :update

    def value = Array.wrap(selected_values).reject { |v| v.blank? }

    def value=(values)
      value_will_change!
      self.selected_values = Array.wrap(values)
    end

    def label = options.slice(*value).values
    alias_method :labels, :label

    private def selected_values_are_legal
      errors.add :value, :invalid if required? && (value.empty? || value.any? { |v| !options.key?(v) })
    end
  end
end
