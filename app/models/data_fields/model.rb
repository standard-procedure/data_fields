module DataFields
  class Model < Base
    data_attribute :value, :string
    metadata_attribute :class_name, :string, default: ""
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
    validate :value_is_correct_class, if: -> { data_value? }, on: :update

    def value
      GlobalID::Locator.locate(data["value"])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def value=(model)
      data["value"] = model.nil? ? nil : model.to_global_id.to_s
    end

    def definition_requires_options? = true

    def self.model_types = MODEL_TYPES

    private def value_is_correct_class
      errors.add :value, :invalid if value.present? && class_name.present? && !value.is_a?(class_name.constantize)
    end

    ModelTypeName = Data.define(:class_name, :name)

    MODEL_TYPES = [Customer, Service, StaffGroup, User].map { |model_type| ModelTypeName.new(class_name: model_type.to_s, name: model_type.model_name.human) }.freeze
    private_constant :MODEL_TYPES, :ModelTypeName
end
end
