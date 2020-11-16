class Headers::ActionableComponent < ApplicationComponent
  with_content_areas :actioner

  def initialize(title:)
    @title = title
  end
end
