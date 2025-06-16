module HasMetadata
  extend ActiveSupport::Concern
  include HasDataAttributes

  class_methods do
    def metadata_attributes(*attributes) = attributes.each { |attribute| metadata_attribute(attribute) }

    def metadata_attribute(name, cast_type = nil, **options) = data_attribute_in :metadata, name, cast_type, **options

    def metadata_model(name, class_name = nil, **options) = model_attribute_in :metadata, name, class_name, **options
  end

  included do
    attribute :metadata, default: {}
  end

  def icon = metadata["icon"] || default_icon

  def icon=(value)
    metadata["icon"] = value
  end

  def default_icon = self.class.name.underscore
end
