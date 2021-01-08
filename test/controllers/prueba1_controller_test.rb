require "test_helper"

class Prueba1ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prueba1_index_url
    assert_response :success
  end
end
