ActionController::Routing::Routes.draw do |map|
  map.namespace :documentation do |doc|
    doc.feature_show 'features/:id', :requirements => { :id => /.*[^(\/edit)]/}, :conditions => { :method => :get },
                     :controller => 'features',
                     :action => 'show'
    doc.feature_update 'features/:id', :requirements => { :id => /.*[^(\/edit)]/}, :conditions => { :method => :post },
                       :controller => 'features',
                       :action => 'update'
    doc.resources :features
    doc.resource :kanban, :controller => 'kanban'
    doc.connect "assets/:path", :controller => 'assets', :action => 'get',
                :requirements => { :path => /.*/ }
  end
end