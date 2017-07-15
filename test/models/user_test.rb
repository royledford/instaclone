require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "lustforlife", first_name: "Iggy",
                      last_name: "Pop", email: "iggy@pop.com",
                      password: "password", password_confirmation: "password")
  end

  test "User should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "       "
    assert_not @user.valid?
  end

  test "first_name should be present" do
    @user.first_name = "       "
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = "       "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.first_name = "       "
    assert_not @user.valid?
  end

  test "Username > 30 characters" do
    @user.username = "a" * 31
    assert_not @user.valid?
  end

  test "first_name > 50 characters" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name > 50 characters" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email > 254 characters" do
    @user.email = "a" * 255
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.c]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "INvalid email address are not allowed" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} is INvalid"
    end
  end

  test "Username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Emails should be all lowercase" do
    test_email = "Iggy@pop.Com"
    @user.email = test_email
    @user.save
    assert_equal test_email.downcase, @user.reload.email
  end

  test "password must be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password not minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
  end

end
