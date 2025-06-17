module DataFields
  class MultiSelect < Field
    include DataFields::HasOptions
    has_attribute :values, type: :json, default: []
    validate :selected_values_are_legal, if: -> { data_value? && required? }, on: :update

    def value = super.reject { |v| v.blank? }

    def label = options.slice(*value).values
    alias_method :labels, :label

    private def selected_values_are_legal
      errors.add :value, :invalid if required? && (value.empty? || value.any? { |v| !options.key?(v) })
    end
  end
end
