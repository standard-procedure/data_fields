module DataFields::Types
  def self.field_types = FIELD_TYPES

  FieldTypeName = Data.define(:class_name, :name, :klass, :element)

  FIELD_TYPES = [
    DataFields::Checkbox,
    DataFields::Date,
    DataFields::DateTime,
    DataFields::Decimal,
    DataFields::Email,
    DataFields::File,
    DataFields::Image,
    DataFields::Model,
    DataFields::MultiSelect,
    DataFields::Number,
    DataFields::Phone,
    DataFields::RichText,
    DataFields::Select,
    DataFields::Text,
    DataFields::Time,
    DataFields::Url,
    DataFields::Signature
  ].map { |field_type|
    FieldTypeName.new(
      class_name: field_type.to_s,
      name: field_type.model_name.human,
      klass: field_type,
      element: field_type.model_name.element
    )
  }.freeze

  private_constant :FIELD_TYPES, :FieldTypeName
end
