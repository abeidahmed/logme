class Containers::AppComponent < ApplicationComponent
  with_content_areas :body

  def initialize(headquarter:, user:)
    @headquarter  = headquarter
    @user         = user
  end
end
