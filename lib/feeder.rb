# frozen_string_literal: true

require 'pry'

require_relative 'authenticator'

class Feeder
    ROOT_PATH = "./data"

    def initialize(username, password)
        @authenticator = Authenticator::Auth.new(username, password)
    end

    def start
        all_items.each do |item|
            response = Net::HTTP.post(url, item.to_json, headers)
            binding.pry
            puts "Status: #{response.code}"
        end
    end

    def all_items
        menu_items.flatten
    end

    private

    def menu_items
        files.map { |file| JSON.parse(file.yield_self { |file| File.read(file) }) }
    end

    def url
        ENV.fetch('API_URL', 'https://api.palestinenights.com')
        .yield_self { |url| "#{url}/menu" }
        .yield_self { |it| URI(it) }
    end

    def headers
        { "Authorization" => "Bearer #{@authenticator.token}" }
    end

    def files
        Dir.glob("#{ROOT_PATH}/**/*.json")
    end
end
