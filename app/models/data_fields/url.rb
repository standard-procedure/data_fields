module DataFields
  class Url < Text
    validates :value, format: /\A#{URI::RFC2396_REGEXP::PATTERN::ABS_URI}\Z/o, if: -> { data_value? && required? }, on: :update
    normalizes :value, with: ->(e) { e.to_s.strip.downcase }
  end
end
