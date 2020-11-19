class Cards::SplitModelComponent < ApplicationComponent
  with_content_areas :left_body, :right_body, :actions

  def initialize(title:, show_actions: false)
    @title        = title
    @show_actions = show_actions
  end
end
