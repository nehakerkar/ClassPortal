require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.create(name: :Jitesh, type: "Instructor", email: "jitesh@ncsu.edu", password: :test123, :deleteable => 1 )
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
