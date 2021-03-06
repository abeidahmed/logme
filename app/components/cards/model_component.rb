class Cards::ModelComponent < ApplicationComponent
  with_content_areas :body, :actions

  def initialize(title:, url:, pending:)
    @title    = title
    @url      = url
    @pending  = pending
  end
end
