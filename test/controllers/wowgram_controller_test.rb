require 'test_helper'

class WowgramControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wowgram_index_url
    assert_response :success
  end

end
