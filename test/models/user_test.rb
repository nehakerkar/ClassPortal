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
  	assert_not @newUser.valid?
  end

  test "user should have email" do
  	@newUser.email = " "
  	assert_not @newUser.valid?
  end

  test "email should be unique" do
  	duplicate_user = @newUser.dup
  	@newuser.save
  	assert_not duplicate_user.valid?

  test "user should have password" do
  	assert_not @newUser.valid?
  end

  test "password should be of min length 3" do
  	@newUser.password = "as"
  	assert_not @newUser.valid?
  end

  test "email should match regex" do
  	@newUser.email = "12"
  	assert_match "/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i", @newUser.email
end
