class Cards::ModelComponent < ApplicationComponent
  with_content_areas :body, :actions

  def initialize(title:, url:)
    @title  = title
    @url    = url
  end
end
