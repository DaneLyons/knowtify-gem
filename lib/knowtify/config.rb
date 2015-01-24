module Knowtify
  class Config
    attr_accessor :api_key,     # String  - API key to override ENV['KNOWTIFY_API_TOKEN']
      :base_url,                # String  - Base url to build requests from
      :api_version,             # String  - API version uses for requests
      :max_retries,             # FixNum  - Default is 2; number of times to retry requests
      :http_client_options,     # Hash    - Additional options to pass to the HTTP client
      :debug,                   # Boolean - Default is false
      :handler,                 # Symbol  - Default is :excon
      :ingore_invalid_contacts  # Boolean - Default is true; when performing Knowtify::Contacts operations (Batch)

    HANDLERS = {
      :excon => Knowtify::ExconHandler
    }.freeze

    def initialize
      @api_key                  = ENV['KNOWTIFY_API_TOKEN']
      @base_url                 = "http://www.knowtify.io"
      @api_version              = "v1"
      @http_client_options      = {}
      @max_retries              = 2
      @debug                    = false
      @handler                  = :excon
      @ingore_invalid_contacts  = true
    end

    def base_path
      "/api/#{@api_version}"
    end

    def debug?
      @debug == true
    end

    def ingore_invalid_contacts?
      @ingore_invalid_contacts == true
    end

    # Until there are more handler options just returns Excon
    def handler
      HANDLERS[@handler]
    end
  end
end
