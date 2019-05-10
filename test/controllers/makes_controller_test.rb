require 'test_helper'

class MakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get makes_index_url
    assert_response :success
  end

end
