require "knowtify/version"
require "knowtify/handlers/excon_handler"
require "knowtify/config"
require "knowtify/client"
require "knowtify/request"
require "knowtify/response"


module Knowtify
  # Your code goes here...
  class << self
    def config
      @config ||= Knowtify::Config.new
    end
  end
end
