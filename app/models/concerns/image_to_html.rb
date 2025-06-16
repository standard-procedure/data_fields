module ImageToHtml
  extend ActiveSupport::Concern

  class_methods do
    def image_tag_for(attachment, alt: "") = "<img src='#{attachment.url}' alt='#{alt}'>"
  end

  private def image_tag_for(attachment, alt: "") = self.class.image_tag_for(attachment, alt: alt)
end
