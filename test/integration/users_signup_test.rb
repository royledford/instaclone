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
end
