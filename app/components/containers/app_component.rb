class Containers::AppComponent < ApplicationComponent
  with_content_areas :body

  def initialize(headquarter:)
    @headquarter = headquarter
  end
end
