module Knowtify
  module Helper
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
      @errors ||= []
      @errors << "Response had authentication error, check you API key."
    end

    def blank_string?(str)
      str =~ /^\s*$/
    end

    def config
      Knowtify.config
    end
  end
end
