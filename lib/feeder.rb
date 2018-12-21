# frozen_string_literal: true

require 'pry'

require_relative 'auth'

class Feeder
    ROOT_PATH = "./data"

    def items
        files.map { JSON.parse(file.yield_self { |file| File.read(file) }) }
    end

    def initialize(username, password)
        @authenticator = Authenticator::Auth.new(username, password)
    end

    def start
        # TODO: Send POST request with Bearer header for each item.
    end

    private

    def files
        Dir.glob("#{ROOT_PATH}/**/*.json")
    end
end
