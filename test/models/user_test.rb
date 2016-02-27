require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@newUser = User.create()
  end

  test "user should have name" do
  	assert @newUser.valid?
  end
end
