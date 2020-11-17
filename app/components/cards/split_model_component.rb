class Cards::SplitModelComponent < ApplicationComponent
  with_content_areas :left_body, :right_body, :actions

  def initialize(title:)
    @title = title
  end
end
