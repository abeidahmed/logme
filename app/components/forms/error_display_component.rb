class Forms::ErrorDisplayComponent < ViewComponent::Base
  def initialize(error:)
    @error = error
  end
end
