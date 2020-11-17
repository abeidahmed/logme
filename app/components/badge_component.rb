class BadgeComponent < ApplicationComponent
  def initialize(type:, title:, label:)
    @type   = type
    @title  = title
    @label  = label
  end
end
