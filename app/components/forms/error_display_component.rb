class Forms::ErrorDisplayComponent < ViewComponent::Base
  def initialize(error_type:)
    @error_type = error_type
  end
end
