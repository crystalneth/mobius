require 'hashie'

module Mobius
  class Response
    def initialize response
      @response = response
    end

    def success?
      data.result_code == '100'
    end

    def data
      @data ||= Hashie::Mash.new(@response.body['response'])
    end

    # ## COMMON STUFF
    # def result_code
    #   data.response_.result_code
    # end

    # def result
    #   data.response_.result
    # end

    # def result_text
    #   data.response_.result_text
    # end
  end
end