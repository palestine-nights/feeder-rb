module Authenticator
    class Auth
        attr_reader :token

        def initialize(username, password)
            @username = username
            @password = password

            # binding.pry

            @token = authenticate!
        end

        def authenticate!
            # req = Net::HTTP::Get.new(uri)
            # req.set_form_data(params)

            # http = Net::HTTP.new(uri.host, uri.port)
            # request = Net::HTTP::Get.new('/auth')
            # request.set_form_data(params)

            # binding.pry

            # response = http.request(request)

            # binding.pry
        end

        private

        def params
            { username: @username, page: @password }
        end

        def uri

            URI(str_uri)
        end

        def str_uri
            ENV.fetch('AUTH_URL', 'https://auth.palestinenights.com')
        end
    end
end
