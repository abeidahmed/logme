class Headers::AppComponent < ApplicationComponent
  def initialize(user:)
    @user = user
  end
end
