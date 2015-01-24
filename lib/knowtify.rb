require 'json'
require 'knowtify/version'
require 'knowtify/handlers/excon_handler'
require 'knowtify/config'
require 'knowtify/client'
require 'knowtify/request'
require 'knowtify/response'
require 'knowtify/helper'
require 'knowtify/contact'
require 'knowtify/contacts'


module Knowtify
  # Your code goes here...
  class << self
    def config
      @config ||= Knowtify::Config.new
    end
  end
end
