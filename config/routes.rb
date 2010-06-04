ActionController::Routing::Routes.draw do |map|
  map.namespace :documentation do |doc|
    doc.resources :features
  end
end