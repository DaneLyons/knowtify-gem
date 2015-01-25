module Knowtify
  module Helper
    AUTHENTICATION_ERROR_MESSAGE = "Knowtify response had authentication error, check your API key.".freeze
    attr_accessor :errors, :response
    def errors
      @errors ||= []
    end

    def client
      @client ||= Knowtify::Client.new
    end

    def parsed_response
      @parsed_response ||= JSON.parse(response.body) if response
      @parsed_response
    end

    def add_authenication_error
      Knowtify.logger.error AUTHENTICATION_ERROR_MESSAGE if Knowtify.logger
      @errors ||= []
      @errors << AUTHENTICATION_ERROR_MESSAGE
    end

    def blank_string?(str)
      str =~ /^\s*$/
    end

    def config
      Knowtify.config
    end
  end
end
