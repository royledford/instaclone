require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "bad signup infomation entered" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: { username: "",
                                        first_name: "test",
                                        last_name: 'bar',
                                        email: 'foo@bar',
                                        password: 'foo',
                                        password_confirmation: 'bar'}}
    end
    assert_template 'users/new'
  end

  test "A user was created" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {user: { username: "john",
                                        first_name: "john",
                                        last_name: 'rotten',
                                        email: 'john@rotton.com',
                                        password: 'dddddd',
                                        password_confirmation: 'dddddd'}}
    end
    follow_redirect!
    assert_template 'users/show'
  end

  # test "valid signup information" do
  #   get signup_path
  #   assert_difference 'User.count', 1 do
  #     post users_path, params: { user: {username: 'jrotten1',
  #                                       email: 'jrotten@example.com',
  #                                       password: 'password',
  #                                       password_confirmation: 'password'}}
  #   end
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert is_logged_in?
  # end


end
