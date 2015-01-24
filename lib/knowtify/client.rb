module Knowtify
  class Client
    attr_accessor :handler

    # TODO: Refactor to separate classes for each method
    def initialize
      @handler = config.handler.new
    end

    # POST /contacts/upsert
    # Sends a request to create or update
    # contacts with the supplied data.
    # Example contacts:
    # [
    #   {
    #     "name":"John",
    #     "email":"john@test.com",
    #     "data":{
    #       "category":"sports",
    #       "followers":300
    #     }
    #   },
    #   {
    #     "name":"Samuel",
    #     "email":"sam@test.com",
    #     "data":{
    #       "category":"sports",
    #       "followers":32,
    #       "comments":54,
    #       "role":"Editor"
    #     }
    #   }
    # ]
    def contacts_create_or_update(contacts=[],request_options={},api_key=nil)
      options = {
        :path => "#{config.base_path}/contacts/upsert",
        :params => {:contacts => contacts},
        :request_options => request_options,
        :api_key => api_key
      }
      request = Knowtify::Request.new(options)
      handler.post(request)
    end
    alias :contacts_upsert :contacts_create_or_update

    # POST /contacts/delete
    # Sends a request to delete contacts whose 
    # emails match those provided.
    # Example contacts:
    # [
    #   "john@test.com",
    #   "sam@test.com",
    #   "sarah@test.com",
    #   "mike@test.com",
    #   "jill@test.com",
    #   "ashley@test.com",
    #   "frank@test.com",
    #   "bill@test.com"
    # ]
    def contacts_delete(contacts=[],http_request_options={},api_key=nil)
      options = {
        :path => "#{config.base_path}/contacts/delete",
        :params => {:contacts => contacts},
        :http_request_options => http_request_options,
        :api_key => api_key
      }
      request = Knowtify::Request.new(options)
      handler.post(request)
    end

    # POST /data/edit
    # Updates global data based on the data provided
    # Example data:
    # {
    #   "users":890,
    #   "comments":994,
    #   "top_story_url":"test.com/story",
    #   "top_story_title":"Article!"
    # }
    def global_edit(data={},http_request_options={},api_key=nil)
      options = {
        :path => "#{config.base_path}/data/edit",
        :params => {:data => data},
        :http_request_options => http_request_options,
        :api_key => api_key
      }
      request = Knowtify::Request.new(options)
      handler.post(request)
    end

    # POST contacts/upsert
    # Sends a transaction email with the event and contacts provided
    # {
    #   "event":"purchase",
    #   "contacts": [
    #     {
    #       "email":"dane@knowtify.io"
    #     }
    #   ]
    # }
    def transactional_email(event, contacts=[],http_request_options={},api_key=nil)
      options = {
        :path => "#{config.base_path}/data/edit",
        :params => {:data => contacts},
        :http_request_options => http_request_options,
        :api_key => api_key
      }
      request = Knowtify::Request.new(options)
      handler.post(request)
    end

    def config
      Knowtify.config
    end
  end
end
