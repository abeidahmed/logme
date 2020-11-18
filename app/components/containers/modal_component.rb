class Containers::ModalComponent < ApplicationComponent
  with_content_areas :body

  def initialize(title:)
    @title = title
  end
end
