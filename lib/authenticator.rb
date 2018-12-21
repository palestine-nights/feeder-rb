module Authenticator
    class Auth
        attr_reader :token

        def initialize(username, password)
            @username = username
            @password = password
            @token = authenticate!
        end

        def authenticate!
            response = Net::HTTP.post(url, params)
            JSON.parse(response.body, symbolize_names: true).dig(:token)
        end

        private

        def params
            { username: @username, password: @password }.to_json
        end

        def url
            ENV.fetch('AUTH_URL', 'https://auth.palestinenights.com')
            .yield_self { |url| "#{url}/auth" }
            .yield_self { |it| URI(it) }
        end
    end
end
