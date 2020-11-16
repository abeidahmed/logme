class App::HeadquartersController < App::ApplicationController
  def index
    skip_policy_scope
  end
end
