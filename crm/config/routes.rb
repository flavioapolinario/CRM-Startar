ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :user_sessions
  map.resources :tasks, :as => "tarefas", :collection=>{:urgent=>:get}
  map.resources :contracts, :as => 'contratos'
  map.resources :users, :as => "usuarios"
  map.resources :projects, :as => "projetos", :has_many=>:documents
  map.resources :customers, :as => "clientes"
  map.root :controller =>"home"
  map.dashboard "/dashboard", :controller=>"home", :action=>"index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
