require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jrotten)
  end

  # test "Login in with password works" do
  #   get login_path
  #   post login_path, params: {session: {email: @user.username,
  #                                             password: 'password'}}
  #   assert_redirected_to @user
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert_select "a[href=?]", login_path, count: 0
  #   assert_select "a[href=?]", logout_path
  #   assert_select "a[href=?]", user_path(@user)
  #
  # end

  test "login with valid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {username: '', password: ''}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
