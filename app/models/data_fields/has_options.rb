module DataFields::HasOptions
  extend ActiveSupport::Concern

  included do
    metadata_attribute :options, default: {}
  end

  def options_as_text = (options || {}).keys.map { |key| "#{key}=#{options[key]}" }.join("\n")

  def options_as_array = (options || {}).keys.map { |key| [options[key], key] }

  def options_as_text=(values)
    self.options = values.to_s.split("\n").each_with_object({}) do |line, result|
      pieces = line.to_s.split("=")
      result[pieces.first] = pieces.last
    end
  end

  def definition_requires_options? = true
end
