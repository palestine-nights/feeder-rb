# frozen_string_literal: true

require 'pry'

require_relative 'auth'

class Feeder
    ROOT_PATH = "./data"

    def initialize
        @authenticator = Authenticator::Auth.new('', '')
    end

    def start
        menu_items.each
    end

    private

    def menu_items
        files.map do |file|
            JSON.parse(file.yield_self { |file| File.read(file) })
        end
    end

    def files
        Dir.glob("#{ROOT_PATH}/**/*.json")
    end
end
