Rails.application.routes.draw do
  post 'documentation/features/:id', :controller => 'documentation/features', :action => :update, :constraints => {:id => /.*[^(\/edit)]/},
       :as => :feature_update
  namespace :documentation do
    get 'features/:id', :action => 'features#show', :constraints => {:id => /.*[^(\/(edit|statistic))]/},
        :as => :feature_show
    resources :features do
      get 'statistic', :on => :collection
      member do
        match 'rename'
        match 'move'
        match 'delete'
      end
    end
  end
  match "documentation/assets/:path", :controller => "documentation/assets", :action => "get", :constraints => {:path => /.*/}
end
