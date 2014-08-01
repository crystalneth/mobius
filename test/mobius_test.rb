require 'test_helper'

class MobiusTest < ActiveSupport::TestCase
  test "prepare_form" do
    api = Mobius::API.new
    resp = api.do :prepare_form,
      :sale => {
        :redirect_url => 'https://localhost/mobius',
        :amount => "1.00"
      }
    assert resp.success?
  end
end
