require 'faraday'
require 'faraday_middleware'

module Mobius
  class Connection
    attr_accessor :secret_key, :key_id

    def initialize secret_key, key_id=nil
      self.secret_key = secret_key
      self.key_id = nil
    end

    def endpoint
      'https://secure.mobiusgateway.com'
    end

    def post path, data
      connection.post path, complete_request(data)
    end


    def complete_request data
      complete_data = data.clone
      complete_data[complete_data.first.first].merge! :api_key => secret_key
      complete_data
    end

    def connection
      @connection ||= Faraday.new(:url=>endpoint) do |conn|
        conn.request :xml
        conn.response :xml

        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
