ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :user_sessions
  map.resources :tasks, :collection=>{:urgent=>:get}
  map.resources :contracts
  map.resources :users
  map.resources :projects, :has_many=>:documents
  map.resources :customers  
  map.root :controller =>"home"
  map.dashboard "/dashboard", :controller=>"home", :action=>"index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
