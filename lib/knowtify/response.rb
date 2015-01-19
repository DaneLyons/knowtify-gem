module Knowtify
  class Response
    attr_accessor :body, :http_code, :raw_response, :count

    ERROR_HTTP_CODES = [500,501,502,503,504,505,429,0]

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

  end
end
