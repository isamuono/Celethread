require 'test_helper'

class ThreadReactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get thread_reactions_create_url
    assert_response :success
  end

end
