require 'test_helper'

class RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get register_new_url
    assert_response :success
  end

end
