require File.dirname(__FILE__) + '/../test_helper'

class SiteControllerTest < ActionController::TestCase

  def test_routing
    assert_routing '',  :controller => 'site', :action => 'front'
    assert_routing '/', :controller => 'site', :action => 'front'
  end
  
  def test_front
    get :front
    
    assert_response :success
    assert_template 'front'
  end
  
end
