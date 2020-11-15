class Containers::FocussedComponent < ApplicationComponent
  with_content_areas :body, :footer

  def initialize(title:)
    @title = title
  end
end
