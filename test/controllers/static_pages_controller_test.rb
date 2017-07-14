require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest


  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "InstaClone | Home"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "InstaClone | Help"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "InstaClone | About"
  end

end
