require 'faraday'
require 'active_support/core_ext/hash'

module Mobius
  # Request middleware that encodes the body as XML.
  #
  # Processes only requests with matching Content-type or those without a type.
  # If a request doesn't have a type but has a body, it sets the Content-type
  # to XML MIME-type.
  #
  # Doesn't try to encode bodies that already are in string form.
  class FaradayXmlRequest < Faraday::Middleware
    CONTENT_TYPE = 'Content-Type'.freeze
    MIME_TYPE    = 'text/xml'.freeze

    dependency do
      require 'active_support/core_ext/hash' unless {}.respond_to?(:to_xml)
    end

    def call(env)
      match_content_type(env) do |data|
        env[:body] = encode data
      end
      @app.call env
    end

    def encode(data)
      unless root = data.first.try(:first)
        raise "no root"
      end
      xml = data[root].to_xml(:root => root)
      # Lovely hack to remove products tag and allow {products: [...]} format without me having to write an xml builder
      xml = xml.sub("<products type=\"array\">\n", '').sub("</products>\n", '')
      puts "REQUEST:\n" + xml
      xml
    end

    def match_content_type(env)
      if process_request?(env)
        env[:request_headers][CONTENT_TYPE] ||= MIME_TYPE
        yield env[:body] unless env[:body].respond_to?(:to_str)
      end
    end

    def process_request?(env)
      type = request_type(env)
      has_body?(env) and (type.empty? or type == MIME_TYPE)
    end

    def has_body?(env)
      body = env[:body] and !(body.respond_to?(:to_str) and body.empty?)
    end

    def request_type(env)
      type = env[:request_headers][CONTENT_TYPE].to_s
      type = type.split(';', 2).first if type.index(';')
      type
    end
  end
end
