ActionController::Routing::Routes.draw do |map|
  
  #site
  map.with_options :controller => "site" do |site|
    #site.connect '/boom',    :action => 'boom'
    site.front   '/',        :action => 'front'
  end
  
  #session
  map.with_options :controller => "session" do |session|
    session.home   '/home',   :action => 'index'
    session.signup '/signup', :action => 'signup'
    session.signup '/login',  :action => 'login'
    session.signup '/logout', :action => 'logout'
  end

end
