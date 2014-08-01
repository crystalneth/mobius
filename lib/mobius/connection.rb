require 'faraday'
require 'faraday_middleware'

module Mobius
  class Connection
    def key_id
      '4683383'
    end

    def secret_key
      '99zt3kvW3T683Z82zfptQ5zPChW57uxn'
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
