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
      @connection ||= Connection.new
    end
  end
end