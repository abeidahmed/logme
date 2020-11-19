class Headers::ActionableComponent < ApplicationComponent
  with_content_areas :actioner

  def initialize(title:, centered: false)
    @title    = title
    @centered = centered
  end
end
