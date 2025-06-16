module DataFields
  class Base < ApplicationRecord
    include PgSearch::Model

    pg_search_scope :search, against: %i[name summary], using: { tsearch: { dictionary: "english", tsvector_column: "search_index" } }

    scope :metadata_field_definitions, -> { metadata_field_definition.where(container: nil).order(:position) }
    scope :form_field_definitions, -> { form_field_definition.order(:position) }

    belongs_to :container, polymorphic: true, optional: true
    validates :container, presence: true, if: -> { form_field_definition? || data_value? }

    has_and_belongs_to_many :service_types, class_name: "ServiceType" # You might stub this out in the test app

    belongs_to :parent, class_name: "DataFields::Base", optional: true
    belongs_to :copied_from, class_name: "DataFields::Base", optional: true

    positioned on: %i[container parent] # If this is a custom concern, make sure it's included in the engine

    enum :data_field_type, data_value: 0, form_field_definition: 1, metadata_field_definition: 2, archived: -1

    include HasMetadata
    include HasName
    include HasDataAttributes

    validates :name, presence: true
    validates :name, uniqueness: { scope: %i[container parent] }, if: -> { !data_value? && !archived? }

    attribute :value
    attribute :data, default: {}

    metadata_attribute :required, :boolean, default: false
    metadata_attribute :allow_comments, :boolean, default: false
    metadata_attribute :allow_files, :boolean, default: false
    metadata_attribute :default_value, :string, default: ""
    metadata_attribute :calculated_value, :string, default: ""
    metadata_attribute :applies_to, :string, default: ""

    data_attribute :repeat_group, :integer, default: 1

    has_rich_text :description
    has_rich_text :comments
    has_many_attached :files

    def copy_into(collection, parent: nil, data_field_type: nil, repeat_group: nil)
      collection.where(copied_from: self).first_or_create!(
        parent: parent,
        position: repeat_group.nil? ? position : :last,
        data_field_type: data_field_type || self.data_field_type,
        name: name,
        type: type,
        metadata: metadata,
        data: data.merge("repeat_group" => repeat_group || self.repeat_group, "value" => ""),
        description: description
      )
    end

    def to_label = model_name.human
    def to_html = value.to_s
    def definition_requires_options? = false

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
end
