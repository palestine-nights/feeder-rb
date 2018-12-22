# frozen_string_literal: true

# Authenticator module.
module Authenticator
  # Class that makes request to auth component (JWT).
  class Auth
    attr_reader :token

    # @param username
    # @param password
    def initialize(username, password)
      @username = username
      @password = password
      @token = authenticate!
    end

    # Receives JWT token for with @username and @password.
    # @return token
    def authenticate!
      response = Net::HTTP.post(url, json_params)
      JSON.parse(response.body, symbolize_names: true).dig(:token)
    end

    private

    def json_params
      params.to_json
    end

    def params
      {
          username: @username,
          password: @password
      }
    end

    def url
      ENV.fetch('AUTH_URL', 'https://auth.palestinenights.com')
          .yield_self {|url| "#{url}/auth"}
          .yield_self {|it| URI(it)}
    end
  end
end
