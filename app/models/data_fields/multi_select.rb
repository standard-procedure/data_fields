module DataFields
  class MultiSelect < Base
    attribute :value, default: []
    include DataFields::HasOptions
    validate :selected_values_are_legal, if: -> { data_value? && required? }, on: :update

    def value = Array.wrap(data["value"]).reject { |v| v.blank? }

    def value=(values)
      value_will_change!
      data["value"] = Array.wrap(values)
    end

    def label = options.slice(*value).values
    alias_method :labels, :label

    private def selected_values_are_legal
      errors.add :value, :invalid if required? && (value.empty? || value.any? { |v| !options.key?(v) })
    end
  end
end
