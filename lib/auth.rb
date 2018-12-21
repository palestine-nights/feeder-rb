module Authenticator
    class Auth
        attr_reader :token

        def initialize(username, password)
            @username = username
            @password = password
        end

        def authenticate!
            binding.pry

            req = Net::HTTP::Get.new(url)
            # req.set_form_data(params)

            # http = Net::HTTP.new(uri.host, uri.port)
            # request = Net::HTTP::Get.new('/auth')
            # request.set_form_data(params)

            # response = http.request(request)
        end

        private

        def params
            { username: @username, page: @password }
        end

        def url
            URI(ENV.fetch('AUTH_URL', 'https://auth.palestinenights.com'))
        end
    end
end
