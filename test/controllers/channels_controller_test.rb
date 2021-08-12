require 'test_helper'

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get channels_new_url
    assert_response :success
  end

end
