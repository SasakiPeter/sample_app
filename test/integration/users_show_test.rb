require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @non_active = users(:lana)
  end

  test "invalid access not activated user" do
    get user_path(@non_active)
    assert_redirected_to root_path
  end
end
