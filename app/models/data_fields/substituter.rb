module DataFields
  class Substituter
    include ImageToHtml

    include Rails.application.routes.url_helpers
    include ActionView::Helpers::AssetUrlHelper
    include ActionView::Helpers::AssetTagHelper

    def default_url_options
      {host: Rails.application.config.action_mailer.default_url_options[:host]}
    end

    def initialize text, *fields, **models
      @text = text.to_s
      @fields = fields.flatten
      @models = models
      @substitutions = build_substitutions
    end

    def to_html
      html = @text.dup
      @substitutions.each do |field_name, value|
        html.gsub! field_name, value.to_s
      end
      html
    end

    def today = I18n.l(Date.today, format: :long)

    def service_name = _service&.name

    def service_description = _service&.description

    def service_logo = _service&.logo&.attached? ? image_tag(url_for(_service.logo), alt: _service.name) : ""

    def service_logo_thumbnail = _service_logo_at(:thumb)

    def service_logo_small = _service_logo_at(:small)

    def service_logo_medium = _service_logo_at(:medium)

    def service_logo_large = _service_logo_at(:large)

    def service_logo_extra_large = _service_logo_at(:xlarge)

    def document_name = _document&.name

    def document_description = _document&.description

    def approved_on = _document.approved_on.nil? ? "" : I18n.l(_document.approved_on, format: :long)

    def expires_on = _document&.expires_on.nil? ? "" : I18n.l(_document.expires_on, format: :long)

    def approved_by = _document&.approved_by

    def approved_by_job_title = _document&.approved_by&.job_title

    def user_name = _user&.name

    def user_first_name = _user&.first_name

    def user_last_name = _user&.last_name

    def user_email = _user&.email_address

    def user_photo = (_user_photo.present? && _user_photo.attached?) ? image_tag_for(_user_photo, alt: _user.name) : ""

    def job_title = _staff_member&.job_title

    def copyright = Rails.application.config.copyright

    def self.tags = standard_field_names + metadata_field_definition_names

    def self.standard_field_names = STANDARD_FIELD_NAMES

    def self.metadata_field_definition_names = @metadata_field_definitions ||= DataField.metadata_field_definitions.order(:name).map(&:name).collect { |name| name.downcase.strip }

    private def build_substitutions
      @text.scan(/(\{\{\s*.+?\s*\}\})/i).each_with_object({}) do |(tag), results|
        field_name = tag.scan(/\{\{\s*(.+?)\s*\}\}/).first.first.strip.downcase
        results[tag] = standard_value_from(message_for(field_name)) || find_field(field_name)&.to_html
      end
    end

    private def find_field(name) = @fields.find { |f| f.name.strip.downcase == name }
    private def standard_value_from(message) = respond_to?(message) ? send(message) : nil
    private def message_for(field_name) = field_name.parameterize(separator: "_")

    private def _staff_member = @models[:staff_member]
    private def _user = _staff_member&.user
    private def _user_photo = _user&.photo

    private def _service = @models[:service]
    private def _service_logo_at(size) = _service&.logo&.attached? ? image_tag(url_for(_service.logo.variant(size)), alt: _service.name) : ""

    private def _revision = @models[:revision]
    private def _revision_created_at = _revision&.created_at&.to_date
    private def _document = _revision&.published_document

    STANDARD_FIELD_NAMES = ["service name", "service description", "service logo", "service logo thumbnail", "service logo small", "service logo medium", "service logo large", "service logo extra large", "user name", "user first name", "user last name", "user email", "user photo", "job title", "today", "approved on", "document name", "expires on", "approved by", "approved by job title", "copyright"].sort.freeze

    private_constant :STANDARD_FIELD_NAMES
  end
end
