module Knowtify
  class Response
    attr_accessor :body,  # String  - body from HTTP request
      :http_code,         # FixNum  - HTTP code from HTTP request
      :raw_response,      # Object  - response object from HTTP client
      :count              # FixNum  - retry count

    ERROR_HTTP_CODES = [500,501,502,503,504,505,429,0].freeze

    def initialize(count=0)
      @count = count || 0
    end

    def retry?
      (((count + 1) <= Knowtify.config.max_retries) && ERROR_HTTP_CODES.include?(http_code))
    end

    def retried?
      count != 0
    end

    def successful?
      http_code == 200
    end

    def authentication_error?
      http_code == 401
    end

  end
end
