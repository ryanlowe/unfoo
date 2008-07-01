ActionController::Routing::Routes.draw do |map|
  
  #site
  map.with_options :controller => "site" do |site|
    #site.connect '/boom',    :action => 'boom'
    site.front   '/',        :action => 'front'
  end
  
  #home
  map.with_options :controller => "home" do |home|
    home.home '/home', :action => 'index'
  end
  
  #session
  map.with_options :controller => "session" do |session|
    session.signup '/signup', :action => 'signup'
    session.login  '/login',  :action => 'login'
    session.logout '/logout', :action => 'logout'
  end

end
