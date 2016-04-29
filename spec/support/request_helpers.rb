module Requests
  module UserHelpers
    def get_token_for_user(user)
      post "/api/v1/sessions", user: {email: user.email, password: user.password}
      JSON.parse(response.body)['auth_token']
    end
  end
end