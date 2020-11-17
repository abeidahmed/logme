class DropdownComponent < ApplicationComponent
  with_content_areas :toggler, :items

  def initialize(position: "right", size: "md")
    @position = position
    @size     = size
  end

  def container_classes
    "dropdown__container dropdown__container--#{@position} dropdown__container--#{@size}"
  end
end
