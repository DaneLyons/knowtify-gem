module Knowtify
  class Contacts
    include Helper

    attr_accessor :contacts,
      :invalid_contacts,
      :http_request_options,
      :api_key,
      :response

    def initialize(contacts = [],opts={})
      @contacts = []
      @invalid_contacts = []
      contacts = (contacts.is_a?(String) ? JSON.parse(contacts) : contacts)
      contacts.each do |contact|
        add(contact)
      end
      opts.each do |meth, val|
        send("#{meth}=",val)
      end
      @http_request_options ||= {}
    end

    def add(contact)
      contact = contact.is_a?(Knowtify::Contact) ? contact : Knowtify::Contact.new(contact)
      if contact.valid?
        @contacts << contact
      else
        @invalid_contacts << contact
      end
      contact
    end
    alias :add_contact :add

    def to_hash
      {'contacts' => contacts.collect(&:to_hash)}
    end

    def to_json
      to_hash.to_json
    end

    def valid?(for_delete=false)
      @errors = []
      @errors << "There are invalid contacts." if !@invalid_contacts.empty? && !config.ingore_invalid_contacts?
      @errors << "There are no valid contacts" if @contacts.empty?
      if @response
        if @response.authentication_error?
          add_authenication_error
        else
          @errors << "#{@contacts.length - parsed_response['successes']} contacts failed to #{for_delete ? 'delete' : 'create/update'}" unless parsed_response['successes'] == @contacts.length
        end
      end
      @errors.empty?
    end

    def save
      @response = client.contacts_create_or_update(contacts.collect(&:to_hash)) if valid?
      valid?
    end

    def emails
      contacts.collect(&:email)
    end

    def delete
      @response = client.delete(emails) if valid?
      valid?
    end

  end
end
