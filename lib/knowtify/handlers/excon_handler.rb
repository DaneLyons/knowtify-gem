require 'excon'
require 'json'
module Knowtify
  class ExconHandler
    attr_accessor :http_client

    def initialize
      opts = {
        :idempotent => true,
        :retry_limit => config.max_retries
      }.merge(config.http_client_options)
      opts[:instrumentor] = Excon::StandardInstrumentor if config.debug? # output full request data if debugging
      @http_client = Excon.new(config.base_url,opts)
    end

    def request_options(request)
      {:path => request.path,
       :body => request.params.to_json,
       :headers => request.headers}.merge(request.http_request_options)
    end

    def post(request,count=0)
      resp = Knowtify::Response.new(count)
      resp.raw_response = http_client.post(request_options(request))
      resp.body = resp.raw_response.body
      resp.http_code = resp.raw_response.status
      if resp.retry?
        post(request,count + 1)
      else
        resp
      end
    end

    def config
      Knowtify.config
    end
  end
end
