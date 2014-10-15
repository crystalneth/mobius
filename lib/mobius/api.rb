module Mobius
  class API
    ACTIONS = {
        :prepare_form => {
          :path => '/api/v2/three-step'
        },
        :complete_form => {
          :path => '/api/v2/three-step'
        },
        :transact => {
          :path => '/api/v2/three-step'
        }
      } 

    def do action_name, data
      action = ACTIONS[action_name]
      Response.new(connection.post action[:path], data)
    end

    def connection
      @connection ||= Connection.new(@secret_key, @key_id)
    end

    def initialize secret_key=nil, key_id=nil
      @secret_key = secret_key || ENV['MOBIUS_SECRET_KEY'] 
      @key_id = key_id || ENV['MOBIUS_KEY_ID'] 
    end
  end
end