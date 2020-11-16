module Requests
  module SessionsHelper
    def login(user)
      cookies[:auth_token] = user.auth_token
    end
  end
end