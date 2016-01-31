require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                              email: "user@invalid",
                              password: "foo",
                              password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid signup creates user and shows flash success" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Test User",
                                            email: "user@valid.com",
                                            password: "123456",
                                            password_confirmation: "123456" }
    end
    assert_template 'users/show'
  end

end