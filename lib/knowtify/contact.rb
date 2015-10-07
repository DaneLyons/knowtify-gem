module Knowtify
  class Contact
    include Helper
    attr_accessor :name,      # String
      :email,                 # String  - REQUIRED
      :data,                  # Hash
      :http_request_options,  # Hash    - options for request
      :api_key,               # String  - Not required if ENV['KNOWTIFY_API_TOKEN'] is set
      :response               # Knowtify::Response object

    def initialize(args={})
      args = JSON.parse(args) if args.is_a?(String)
      args.each do |meth,val|
        send("#{meth}=",val)
      end
      @http_request_options ||= {}
    end

    def name=name
      @name=name unless blank_string?(name)
    end

    def name?
      !@name.nil?
    end

    def email=email
      @email=email unless blank_string?(email)
    end

    def email?
      !@email.nil?
    end

    def data=data
      @data = data unless blank_string?(data.to_s)
    end

    def data?
      @data.empty?
    end

    def to_hash
      hash = { 'name' => name,
               'email' => email }
      hash['data'] = data unless data.empty?
      hash
    end

    def to_json
      to_hash.to_json
    end

    def valid?(for_delete=false)
      @errors = [] # reset
      @errors << "Email is blank." unless email?
      if @response
        if @response.authentication_error?
          add_authenication_error
        else
          if parsed_response['contacts_errored'] > 0
            action = (for_delete ? 'delete' : 'create/update')
            Knowtify.logger.error "Knowtify contacts #{action} operation failed: #{response.body}." if Knowtify.logger
            @errors << "Contact failed to #{action}"
          end
        end
      end
      @errors.empty?
    end

    def save
      if valid?
        @response = client.contacts_create_or_update([to_hash],http_request_options,api_key)
      end
      valid?
    end

    def delete
      @response = client.contacts_delete([email],http_request_options,api_key) if valid?(true)
      valid?(true)
    end
  end
end
