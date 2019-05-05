require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get application_home_url
    assert_response :success
  end

end
