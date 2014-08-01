require 'faraday'
require 'mobius/faraday_xml_request'
require 'mobius/connection'
require 'mobius/api'
require 'mobius/response'

module Mobius
  Faraday.register_middleware :request,
    :xml    => FaradayXmlRequest
end
