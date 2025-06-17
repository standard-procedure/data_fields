module DataFields
  class Email < Text
    validates :value, format: URI::MailTo::EMAIL_REGEXP, if: -> { data_value? }, on: :update
    validates :value, presence: true, if: -> { data_value? && required? }, on: :update
    normalizes :value, with: ->(e) { e.to_s.strip.downcase }
  end
end
