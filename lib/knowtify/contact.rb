module Knowtify
  class Contact
    include Helper
    attr_accessor :name, :email, :data,:http_request_options, :api_key, :response

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
          @errors << "Contact failed to #{for_delete ? "delete" : "create/update"}" unless parsed_response['successes'] == 1
        end
      end
      @errors.empty?
    end

    def save
      @response = client.contacts_create_or_update([to_hash],http_request_options,api_key) if valid?
      valid?
    end

    def delete
      @response = client.delete([email],http_request_options,api_key) if valid?
      valid?
    end
  end
end
