module DataFields
  class MultiSelect < Field
    include DataFields::HasOptions
    has_attribute :values, type: :json, default: []
    validate :values_are_present, if: -> { data_value? && required? }, on: :update
    validate :values_are_legal, if: -> { data_value? }, on: :update

    def value = super.reject { |v| v.blank? }

    def value=(values)
      super(Array.wrap(values))
    end

    def label = options.slice(*value).values
    alias_method :labels, :label

    private def values_are_legal
      errors.add :value, :invalid if value.any? { |v| !options.key?(v) }
    end
    private def values_are_present
      errors.add :value, :invalid if value.empty?
    end
  end
end
