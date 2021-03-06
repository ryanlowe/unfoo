require File.dirname(__FILE__) + '/../test_helper'

class HomeControllerTest < ActionController::TestCase
  fixtures :users
  
  def test_routing
    assert_routing '/home', :controller => 'home', :action => 'index'
  end
  
  def test_index
    login_as :ryan
    
    get :index
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_index_not_logged_in
    get :index
    
    assert_response :redirect
    assert_redirected_to login_url
  end
  
  def test_should_login_with_cookie
    users(:ryan).remember_me
    @request.cookies["auth_token"] = cookie_for(:ryan)
    get :index
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    users(:ryan).remember_me
    users(:ryan).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:ryan)
    get :index
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:ryan).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :index
    assert !@controller.send(:logged_in?)
  end

  protected
  
    # def create_user(options = {})
    #   post :signup, :user => { :username => 'quire', 
    #     :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    # end
    
    def auth_token(token)
      CGI::Cookie.new('name' => 'auth_token', 'value' => token)
    end
    
    def cookie_for(user)
      auth_token users(user).remember_token
    end
  
end
