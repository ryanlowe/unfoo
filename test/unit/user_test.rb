require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :users

  def test_fixtures
    users(:ryan).valid?
    users(:jonny).valid?
  end

  def test_should_create_user
    assert_difference User, :count do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_username
    assert_no_difference User, :count do
      u = create_user(:username => nil)
      assert u.errors.on(:username)
    end
  end

  def test_should_require_password
    assert_no_difference User, :count do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference User, :count do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  # def test_should_require_email
  #   assert_no_difference User, :count do
  #     u = create_user(:email => nil)
  #     assert u.errors.on(:email)
  #   end
  # end

  def test_should_reset_password
    users(:ryan).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:ryan), User.authenticate('ryan', 'new password')
  end

  def test_should_not_rehash_password
    users(:ryan).update_attributes(:username => 'ryan2')
    assert_equal users(:ryan), User.authenticate('ryan2', 'test')
  end

  def test_should_authenticate_user
    assert_equal users(:ryan), User.authenticate('ryan', 'test')
  end

  def test_should_set_remember_token
    users(:ryan).remember_me
    assert_not_nil users(:ryan).remember_token
    assert_not_nil users(:ryan).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:ryan).remember_me
    assert_not_nil users(:ryan).remember_token
    users(:ryan).forget_me
    assert_nil users(:ryan).remember_token
  end

  protected
    def create_user(options = {})
      User.create({ :username => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    end
end
