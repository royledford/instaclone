require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jrotten)
  end

  test "unscuccessful user edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "",
                                            first_name: "",
                                            last_name: "",
                                            email: "foo@invalid",
                                            password: "foo",
                                            password_confirmation: "baz"
                                            }}

    assert_template "users/edit"
    assert_select "div.flash-error", "The form contains 6 errors"
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    username = "foo bar"
    first_name = "foo"
    last_name = "bar"
    email = "foo@bar.com"

    patch user_path(@user), params: { user: { username: username,
                                            first_name: first_name,
                                            last_name: last_name,
                                            email: email,
                                            password: "",
                                            password_confirmation: ""
                                            }}

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email


  end
end
