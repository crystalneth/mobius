module Mobius
  class Response
    def initialize response
      @response = response
    end

    def success?
      data.response_.result_code == '100'
    end

    def data
      @data ||= Hashie::Mash.new(@response.body)
    end
  end
end