require "has_attributes"

module DataFields
  class Field < ApplicationRecord
    include PgSearch::Model
    include HasName
    include HasAttributes

    pg_search_scope :search, against: %i[name summary], using: {tsearch: {dictionary: "english", tsvector_column: "search_index"}}

    scope :metadata_field_definitions, -> { metadata_field_definition.where(container: nil).order(:position) }
    scope :form_field_definitions, -> { form_field_definition.order(:position) }

    belongs_to :container, polymorphic: true, optional: true
    validates :container, presence: true, if: -> { form_field_definition? || data_value? }
    belongs_to :parent, class_name: "DataFields::Field", optional: true
    belongs_to :copied_from, class_name: "DataFields::Field", optional: true

    positioned on: [:container, :parent]
    enum :data_field_type, data_value: 0, form_field_definition: 1, metadata_field_definition: 2, archived: -1
    serialize :data, type: Hash, coder: JSON
    serialize :metadata, type: Hash, coder: JSON
    validates :name, presence: true
    validates :name, uniqueness: {scope: %i[container parent]}, if: -> { !data_value? && !archived? }
    attribute :value
    attribute :data, default: {}
    has_attribute :required, :boolean, default: false, field_name: "metadata"
    has_attribute :allow_comments, :boolean, default: false, field_name: "metadata"
    has_attribute :allow_files, :boolean, default: false, field_name: "metadata"
    has_attribute :default_value, :string, default: "", field_name: "metadata"
    has_attribute :calculated_value, :string, default: "", field_name: "metadata"
    has_attribute :applies_to, :string, default: "", field_name: "metadata"
    has_attribute :field_name, :string, default: "hello", field_name: "metadata"
    has_attribute :repeat_group, :integer, default: 1
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
  end
end
