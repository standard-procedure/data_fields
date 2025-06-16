module HasName
  extend ActiveSupport::Concern

  def to_s = name

  def to_param = "#{id}-#{name}".parameterize
end
