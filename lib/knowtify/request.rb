module Knowtify
  # A generic request object to be passed to handlers
  class Request
    attr_accessor :api_key, # API key for request; defaults to config.api_key
      :path,				# Path for HTTP HTTP request
      :params,				# Parameters for HTTP request
      :http_request_options # Additional options pass to HTTP client during the request action

    def initialize(options={})
      @api_key = options[:api_key] || config.api_key
      @path = options[:path]
      @params = options[:params]
      @http_request_options = options[:http_request_options] || {}
    end

    def headers
      {"Content-Type" => "application/json",
       'Authorization' => "Token token=\"#{api_key}\""}
    end

    def config
    	Knowtify.config
    end
  end
end
