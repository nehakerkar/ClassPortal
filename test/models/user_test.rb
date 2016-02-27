require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@newUser = User.create()
  end

  test "user should have name" do
  	@newUser.name = " "
  	assert_not @newUser.valid?, "User: Empty user name is being allowed"
  end

  test "user should have email" do
  	@newUser.email = " "
  	assert_not @newUser.valid?, "User: Empty email is being allowed"
  end

  test "email should be unique" do
  	duplicate_user = @newUser.dup
  	@newUser.save
  	assert_not duplicate_user.valid?, "User, Duplicate Email ID is being allowed"
  end

  test "user should have password" do
  	assert_not @newUser.valid?, "User, User is being created without password"
  end

  test "password should be of min length 3" do
  	@newUser.password = "as"
  	assert_not @newUser.valid?, "User: Password of user is less than minimum length"
  end

  test "email should match regex" do
  	@newUser.email = "12"
  	assert_no_match "/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i", @newUser.email, "User: Email address is in invalid format"
  end

  test "is type valid" do
  	@newUser.type = "blah"
  	assert_not @newUser.valid?, "User: User type is invalid"
  end

end
